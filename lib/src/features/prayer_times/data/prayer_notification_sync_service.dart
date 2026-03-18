import 'package:sabail/src/core/notifications/notification_service.dart';
import 'package:sabail/src/features/prayer_times/domain/entities/prayer_day.dart';
import 'package:sabail/src/features/prayer_times/presentation/viewmodels/prayer_location_store.dart';

import 'prayer_times_service.dart';

class PrayerNotificationSyncService {
  static const int _scheduleWindowDays = 60;

  final PrayerTimesService service;
  final NotificationService notificationService;
  final PrayerLocationStore locationStore;

  PrayerNotificationSyncService({
    required this.service,
    required this.notificationService,
    required this.locationStore,
  });

  Future<void> syncSavedSchedule() async {
    if (!locationStore.hasSavedLocation) {
      return;
    }

    if (locationStore.hasCoordinates) {
      await syncForCoords(
        latitude: locationStore.latitude!,
        longitude: locationStore.longitude!,
        requestPermissions: false,
      );
      return;
    }

    await syncForCity(
      city: locationStore.city,
      country: locationStore.country,
      requestPermissions: false,
    );
  }

  Future<void> syncForCity({
    required String city,
    required String country,
    bool requestPermissions = true,
  }) async {
    final hasPermissions = await notificationService.ensurePermissions(
      requestIfNeeded: requestPermissions,
    );
    if (!hasPermissions) {
      if (requestPermissions) {
        throw StateError(
          'Allow notifications and exact alarms so prayer alerts arrive on time.',
        );
      }
      return;
    }

    final days = await service.fetchUpcomingByCity(
      city: city,
      country: country,
      horizonDays: _scheduleWindowDays,
    );
    await notificationService.replacePrayerSchedule(_buildNotifications(days));
  }

  Future<void> syncForCoords({
    required double latitude,
    required double longitude,
    bool requestPermissions = true,
  }) async {
    final hasPermissions = await notificationService.ensurePermissions(
      requestIfNeeded: requestPermissions,
    );
    if (!hasPermissions) {
      if (requestPermissions) {
        throw StateError(
          'Allow notifications and exact alarms so prayer alerts arrive on time.',
        );
      }
      return;
    }

    final days = await service.fetchUpcomingByCoords(
      latitude: latitude,
      longitude: longitude,
      horizonDays: _scheduleWindowDays,
    );
    await notificationService.replacePrayerSchedule(_buildNotifications(days));
  }

  List<ScheduledPrayerNotification> _buildNotifications(List<PrayerDay> days) {
    final now = DateTime.now();
    final notifications = <ScheduledPrayerNotification>[];

    for (final day in days) {
      final date = DateTime(day.date.year, day.date.month, day.date.day);
      final prayers = <(String, int)>[
        ('Fajr', day.fajrMinutes),
        ('Dhuhr', day.dhuhrMinutes),
        ('Asr', day.asrMinutes),
        ('Maghrib', day.maghribMinutes),
        ('Isha', day.ishaMinutes),
      ];

      for (var index = 0; index < prayers.length; index++) {
        final prayer = prayers[index];
        final scheduledAt = date.add(Duration(minutes: prayer.$2));
        if (!scheduledAt.isAfter(now)) {
          continue;
        }

        notifications.add(
          ScheduledPrayerNotification(
            id: _notificationId(date, index),
            scheduledAt: scheduledAt,
            title: prayer.$1,
            body: 'Prayer time at ${_formatTime(prayer.$2)}',
          ),
        );
      }
    }

    return notifications;
  }

  int _notificationId(DateTime date, int prayerIndex) {
    final compactDate = (date.year * 10000) + (date.month * 100) + date.day;
    return (compactDate * 10) + prayerIndex;
  }

  String _formatTime(int minutesFromMidnight) {
    final hour = (minutesFromMidnight ~/ 60).toString().padLeft(2, '0');
    final minute = (minutesFromMidnight % 60).toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
