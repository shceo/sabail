import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sabail/src/domain/api/api.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

Future<void> schedulePrayerTimeNotifications(String selectedCity) async {
  // Initialize the notifications plugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Notification channel settings for Android
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'prayer_channel_id',
    'Prayer Channel',
    channelDescription: 'Channel for prayer time notifications',
    importance: Importance.max,
    priority: Priority.high,
  );

  // Create NotificationDetails
  final NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  try {
    final hijriApi = HijriApi();
    final prayerTimesApi = PrayerTimes();

    // Get current hijri date
    final hijriDate = await hijriApi.getCurrentHijriDate();

    // Get prayer times for the current day and selected city
    final prayerTimes = await prayerTimesApi.getPrayerTime(
      selectedCity,
      DateTime.now(),
      0,
    );

    // Parse prayer times; assume they are comma-separated strings
    final List<String> prayerTimeList = prayerTimes.split(', ');

    // DateFormat for parsing prayer time strings (e.g. "5:30 PM")
    final DateFormat dateFormat = DateFormat('h:mm a');

    // Set notifications for each prayer time
    for (String prayerTime in prayerTimeList) {
      final List<String> prayerTimeSplit = prayerTime.split(': ');
      if (prayerTimeSplit.length < 2) continue;
      final String prayerName = prayerTimeSplit[0];
      final String prayerTimeString = prayerTimeSplit[1];

      // Parse prayer time
      final DateTime parsedTime = dateFormat.parse(prayerTimeString);

      // Combine today's date with the parsed time
      final now = DateTime.now();
      final DateTime prayerDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        parsedTime.hour,
        parsedTime.minute,
      );

      // Notification title and body
      final String notificationTitle = 'Время Молитвы ($hijriDate)';
      final String notificationBody = '$prayerName в $prayerTimeString';

      // Convert to device's local time zone
      final tz.TZDateTime scheduledPrayerDateTime =
          tz.TZDateTime.from(prayerDateTime, tz.local);

      // Schedule the notification
      await flutterLocalNotificationsPlugin.zonedSchedule(
        prayerName.hashCode, // Unique identifier
        notificationTitle,
        notificationBody,
        scheduledPrayerDateTime,
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exact,
        // androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  } catch (error) {
    print('Error scheduling prayer time notifications: $error');
  }
}
