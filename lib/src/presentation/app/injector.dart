import 'package:get_it/get_it.dart';
import 'package:sabail/src/data/locale/city_dao.dart';
import 'package:sabail/src/data/locale/db.dart';
import 'package:sabail/src/data/repositories/city_repository_impl.dart';
import 'package:sabail/src/domain/api/api.dart';
import 'package:sabail/src/domain/blocs/splash_bloc/splash_screen_bloc.dart';
import 'package:sabail/src/domain/repositories/city_repository.dart';
import 'package:sabail/src/domain/usecases/get_city_usecase.dart';
import 'package:sabail/src/presentation/features/home/view_model/home_vm.dart';
import 'package:sabail/src/presentation/features/prayer_times/view_model/prayer_vm.dart';
import 'package:sabail/src/presentation/features/profile/view_model/profile_vm.dart';

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

  // 5) ViewModels
  sl.registerFactory<ProfileViewModel>(
    () => ProfileViewModel(getCity: sl<GetCityUseCase>()),
  );

  // 6) Splash
  sl.registerFactory<SplashBloc>(() => SplashBloc());

  sl.registerLazySingleton<HijriApi>(() => HijriApi());
  sl.registerLazySingleton<PrayerTimes>(() => PrayerTimes());
  sl.registerFactory<HomeViewModel>(() => HomeViewModel(
        hijriApi: sl<HijriApi>(),
        prayerApi: sl<PrayerTimes>(),
        cityRepo: sl<CityRepository>(),
      ));

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
