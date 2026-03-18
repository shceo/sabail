import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const _androidAzanChannelId = 'azan_channel_krasivyj_v2';
const _androidAzanChannelName = 'Azan Notifications';
const _androidAzanChannelDescription = 'Prayer reminders with azan audio';
const _androidAzanSoundName = 'krasivyj_azan';

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

  Future<void> init() async {
    if (_initialized) return;
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

    await _ensureChannel();
    _initialized = true;
  }

  Future<bool> ensurePermissions({bool requestIfNeeded = true}) async {
    await init();

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

  Future<void> _ensureChannel() async {
    const androidChannel = AndroidNotificationChannel(
      _androidAzanChannelId,
      _androidAzanChannelName,
      description: _androidAzanChannelDescription,
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound(_androidAzanSoundName),
      playSound: true,
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);
  }

  Future<void> replacePrayerSchedule(
    Iterable<ScheduledPrayerNotification> notifications,
  ) async {
    await init();
    await _plugin.cancelAll();

    for (final notification in notifications) {
      await _plugin.zonedSchedule(
        notification.id,
        notification.title,
        notification.body,
        tz.TZDateTime.from(notification.scheduledAt, tz.local),
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidAzanChannelId,
            _androidAzanChannelName,
            channelDescription: _androidAzanChannelDescription,
            sound: const RawResourceAndroidNotificationSound(
              _androidAzanSoundName,
            ),
            playSound: true,
            importance: Importance.max,
            priority: Priority.max,
          ),
          iOS: const DarwinNotificationDetails(sound: 'default'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
