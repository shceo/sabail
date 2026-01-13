import 'package:get_it/get_it.dart';
import 'package:sabail/src/data/locale/app_db.dart';
import 'package:sabail/src/features/prayer_times/data/prayer_times_repository.dart';
import 'package:sabail/src/features/prayer_times/data/prayer_times_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  if (!locator.isRegistered<AppDatabase>()) {
    locator.registerLazySingleton<AppDatabase>(AppDatabase.open);
  }

  locator
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
