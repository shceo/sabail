import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings =
        InitializationSettings(android: androidInit, iOS: iosInit);
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

  Future<void> _ensureChannel() async {
    const androidChannel = AndroidNotificationChannel(
      'azan_channel',
      'Azan Notifications',
      description: 'Уведомления с азаном в расписании намазов',
      importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('azan'),
      playSound: true,
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  Future<void> scheduleDailyAzan({
    required int id,
    required DateTime date,
    required int minutesFromMidnight,
    required String title,
  }) async {
    await init();
    final scheduled = tz.TZDateTime(
      tz.local,
      date.year,
      date.month,
      date.day,
    ).add(Duration(minutes: minutesFromMidnight));

    final now = DateTime.now();
    var runAt = scheduled;
    if (runAt.isBefore(now)) {
      runAt = runAt.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      id,
      title,
      'Время молитвы',
      runAt,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'azan_channel',
          'Azan Notifications',
          channelDescription: 'Уведомления с азаном',
          sound: const RawResourceAndroidNotificationSound('azan'),
          playSound: true,
          importance: Importance.max,
          priority: Priority.max,
        ),
        iOS: const DarwinNotificationDetails(sound: 'default'),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
