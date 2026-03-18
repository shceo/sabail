import 'package:get_it/get_it.dart';
import 'package:sabail/src/data/locale/app_db.dart';
import 'package:sabail/src/core/notifications/notification_service.dart';
import 'package:sabail/src/core/services/city_service.dart';
import 'package:sabail/src/core/services/location_service.dart';
import 'package:sabail/src/features/prayer_times/data/prayer_notification_sync_service.dart';
import 'package:sabail/src/features/prayer_times/data/prayer_times_repository.dart';
import 'package:sabail/src/features/prayer_times/data/prayer_times_service.dart';
import 'package:sabail/src/features/prayer_times/presentation/viewmodels/prayer_location_store.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  if (!locator.isRegistered<AppDatabase>()) {
    locator.registerLazySingleton<AppDatabase>(AppDatabase.open);
  }

  if (!locator.isRegistered<NotificationService>()) {
    locator.registerLazySingleton<NotificationService>(
      () => NotificationService(),
    );
  }

  if (!locator.isRegistered<LocationService>()) {
    locator.registerLazySingleton<LocationService>(() => LocationService());
  }

  if (!locator.isRegistered<CityService>()) {
    locator.registerLazySingleton<CityService>(() => CityService());
  }

  if (!locator.isRegistered<PrayerLocationStore>()) {
    final locationStore = PrayerLocationStore();
    await locationStore.init();
    locator.registerSingleton<PrayerLocationStore>(locationStore);
  }

  if (!locator.isRegistered<PrayerTimesService>()) {
    locator.registerLazySingleton<PrayerTimesService>(
      () => PrayerTimesService(),
    );
  }

  if (!locator.isRegistered<PrayerTimesRepository>()) {
    locator.registerLazySingleton<PrayerTimesRepository>(
      () => PrayerTimesRepository(
        db: locator<AppDatabase>(),
        service: locator<PrayerTimesService>(),
      ),
    );
  }

  if (!locator.isRegistered<PrayerNotificationSyncService>()) {
    locator.registerLazySingleton<PrayerNotificationSyncService>(
      () => PrayerNotificationSyncService(
        service: locator<PrayerTimesService>(),
        notificationService: locator<NotificationService>(),
        locationStore: locator<PrayerLocationStore>(),
      ),
    );
  }
}
