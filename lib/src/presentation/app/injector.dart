import 'package:get_it/get_it.dart';
import 'package:sabail/src/data/locale/city_dao.dart';
import 'package:sabail/src/data/locale/db.dart';
import 'package:sabail/src/data/repositories/city_repository_impl.dart';
import 'package:sabail/src/domain/api/api.dart';
import 'package:sabail/src/presentation/features/splash/cubit/splash_cubit.dart';
import 'package:sabail/src/domain/repositories/city_repository.dart';
import 'package:sabail/src/domain/usecases/get_city_usecase.dart';
import 'package:sabail/src/presentation/features/home/cubit/home_cubit.dart';
import 'package:sabail/src/presentation/features/prayer_times/cubit/prayer_cubit.dart';
import 'package:sabail/src/presentation/features/profile/cubit/profile_cubit.dart';
import 'package:sabail/src/presentation/features/auth/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 1) Core / externals
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // 2) DAOs
  sl.registerLazySingleton<CityDao>(() => CityDao(sl<AppDatabase>()));

  // 3) Repositories (Data → Domain)
  sl.registerLazySingleton<CityRepository>(
    () => CityRepositoryImpl(sl<CityDao>()),
  );

  // 4) UseCases
  sl.registerLazySingleton<GetCityUseCase>(
    () => GetCityUseCase(sl<CityRepository>()),
  );

  // 5) Cubits
  sl.registerFactory<ProfileCubit>(
    () => ProfileCubit(getCity: sl<GetCityUseCase>()),
  );

  // 6) Splash
  sl.registerFactory<SplashCubit>(() => SplashCubit());

  sl.registerLazySingleton<HijriApi>(() => HijriApi());
  sl.registerLazySingleton<PrayerTimes>(() => PrayerTimes());
  sl.registerFactory<HomeCubit>(
    () => HomeCubit(
      hijriApi: sl<HijriApi>(),
      prayerApi: sl<PrayerTimes>(),
      cityRepo: sl<CityRepository>(),
    ),
  );

  sl.registerFactory<AuthCubit>(() => AuthCubit());

  sl.registerFactory<PrayerCubit>(
    () => PrayerCubit(
      prayerApi: sl<PrayerTimes>(),
      cityRepo: sl<CityRepository>(),
    ),
  );

  // sl.registerLazySingleton<PrayerTimes>(() => PrayerTimes());
  // sl.registerFactory<PrayerViewModel>(
  //   () => PrayerViewModel(
  //     prayerApi: sl<PrayerTimes>(),
  //     cityRepo: sl<CityRepository>(),
  //   ),
  // );

  // Если позже понадобятся другие VM — просто добавьте их сюда:
  // sl.registerFactory<QuranViewModel>(() => QuranViewModel());
  // sl.registerFactory<PrayerViewModel>(() => PrayerViewModel());
}
