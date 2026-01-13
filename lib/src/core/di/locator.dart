import 'package:get_it/get_it.dart';
import 'package:sabail/src/data/locale/app_db.dart';
import 'package:sabail/src/core/notifications/notification_service.dart';
import 'package:sabail/src/core/services/city_service.dart';
import 'package:sabail/src/core/services/location_service.dart';
import 'package:sabail/src/features/prayer_times/data/prayer_times_repository.dart';
import 'package:sabail/src/features/prayer_times/data/prayer_times_service.dart';
import 'package:sabail/src/features/prayer_times/presentation/viewmodels/prayer_location_store.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  if (!locator.isRegistered<AppDatabase>()) {
    locator.registerLazySingleton<AppDatabase>(AppDatabase.open);
  }

  locator
    ..registerLazySingleton<NotificationService>(
      () => NotificationService(),
    )
    ..registerLazySingleton<LocationService>(() => LocationService())
    ..registerLazySingleton<CityService>(() => CityService())
    ..registerLazySingleton<PrayerLocationStore>(() => PrayerLocationStore())
    ..registerLazySingleton<PrayerTimesService>(
      () => PrayerTimesService(),
    )
    ..registerLazySingleton<PrayerTimesRepository>(
      () => PrayerTimesRepository(
        db: locator<AppDatabase>(),
        service: locator<PrayerTimesService>(),
      ),
    );
}
