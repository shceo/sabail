import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sabail/domain/api/api.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

Future<void> schedulePrayerTimeNotifications(String selectedCity) async {
  // Initialize the notifications plugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Notification channel settings for Android
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'prayer_channel_id',
    'Prayer Channel',
    importance: Importance.max,
    priority: Priority.high,
  );

  // Create NotificationDetails
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  // Get prayer times and set notifications for each time
  try {
    final hijriApi = HijriApi();
    final prayerTimesApi = PrayerTimes();

    // Get current hijri date
    final hijriDate = await hijriApi.getCurrentHijriDate();

    // Get prayer times for the current day and selected city
    final prayerTimes = await prayerTimesApi.getPrayerTime(selectedCity, DateTime.now(), 0);

    // Parse prayer times
    final List<String> prayerTimeList = prayerTimes.split(', ');

    // Format prayer times for notifications
    final DateFormat dateFormat = DateFormat('h:mm a');

    // Set notifications for each prayer time
    for (String prayerTime in prayerTimeList) {
      final List<String> prayerTimeSplit = prayerTime.split(': ');
      final String prayerName = prayerTimeSplit[0];
      final String prayerTimeString = prayerTimeSplit[1];

      // Parse prayer time
      final DateTime prayerDateTime = dateFormat.parse(prayerTimeString);

      // Notification title
      final String notificationTitle = 'Время Молитвы ($hijriDate)';

      // Notification body
      final String notificationBody = '$prayerName в $prayerTimeString';

      // Create prayer time in the device's time zone
      final tz.TZDateTime scheduledPrayerDateTime = tz.TZDateTime.from(prayerDateTime, tz.local);

      // Set notification for prayer time
      await flutterLocalNotificationsPlugin.zonedSchedule(
        prayerName.hashCode, // Use prayer name hash code as identifier
        notificationTitle,
        notificationBody,
        scheduledPrayerDateTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  } catch (error) {
    // Error handling
    print('Error scheduling prayer time notifications: $error');
  }
}
