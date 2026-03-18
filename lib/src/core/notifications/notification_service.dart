import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const _nativeNotificationChannel = MethodChannel(
  'com.example.sabail/native_notifications',
);

class ScheduledPrayerNotification {
  final int id;
  final DateTime scheduledAt;
  final String title;
  final String body;

  const ScheduledPrayerNotification({
    required this.id,
    required this.scheduledAt,
    required this.title,
    required this.body,
  });
}

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  bool get _usesNativeAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

  Future<void> init() async {
    if (_initialized) return;

    if (_usesNativeAndroid) {
      await _nativeNotificationChannel.invokeMethod<void>('initialize');
      _initialized = true;
      return;
    }

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await _plugin.initialize(initSettings);

    tz.initializeTimeZones();
    try {
      final timeZoneInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneInfo.identifier));
    } catch (_) {
      tz.setLocalLocation(tz.UTC);
    }

    _initialized = true;
  }

  Future<bool> ensurePermissions({bool requestIfNeeded = true}) async {
    await init();

    if (_usesNativeAndroid) {
      return await _nativeNotificationChannel.invokeMethod<bool>(
            'ensurePermissions',
            <String, dynamic>{'requestIfNeeded': requestIfNeeded},
          ) ??
          false;
    }

    final android =
        _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
    if (android == null) {
      return true;
    }

    var notificationsEnabled = await android.areNotificationsEnabled() ?? true;
    if (!notificationsEnabled && requestIfNeeded) {
      notificationsEnabled =
          await android.requestNotificationsPermission() ?? false;
    }
    if (!notificationsEnabled) {
      return false;
    }

    var exactNotificationsEnabled =
        await android.canScheduleExactNotifications() ?? true;
    if (!exactNotificationsEnabled && requestIfNeeded) {
      exactNotificationsEnabled =
          await android.requestExactAlarmsPermission() ?? false;
    }

    return exactNotificationsEnabled;
  }

  Future<void> replacePrayerSchedule(
    Iterable<ScheduledPrayerNotification> notifications,
  ) async {
    await init();

    if (_usesNativeAndroid) {
      await _nativeNotificationChannel.invokeMethod<void>(
        'replacePrayerSchedule',
        <String, dynamic>{
          'notifications':
              notifications
                  .map(
                    (notification) => <String, dynamic>{
                      'id': notification.id,
                      'triggerAtMillis':
                          notification.scheduledAt.millisecondsSinceEpoch,
                      'title': notification.title,
                      'body': notification.body,
                    },
                  )
                  .toList(),
        },
      );
      return;
    }

    await _plugin.cancelAll();

    for (final notification in notifications) {
      await _plugin.zonedSchedule(
        notification.id,
        notification.title,
        notification.body,
        tz.TZDateTime.from(notification.scheduledAt, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'azan_channel_flutter_fallback',
            'Azan Notifications',
            channelDescription: 'Prayer reminders with azan audio',
          ),
          iOS: DarwinNotificationDetails(sound: 'default'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> cancelAll() async {
    await init();

    if (_usesNativeAndroid) {
      await _nativeNotificationChannel.invokeMethod<void>('cancelAll');
      return;
    }

    await _plugin.cancelAll();
  }
}
