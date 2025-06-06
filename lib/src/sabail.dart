import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1) Подключаем инициализацию и сам GetIt
import 'package:sabail/src/presentation/app/injector.dart';
import 'package:sabail/src/data/locale/db.dart';
import 'package:sabail/src/presentation/app/router.dart';
import 'package:sabail/src/presentation/features/home/view/home.dart';
import 'package:sabail/src/presentation/features/home/view/home_screen.dart';
import 'package:sabail/src/presentation/features/home/cubit/home_cubit.dart';
import 'package:sabail/src/presentation/features/splash/view/splash_screen.dart';
import 'package:sabail/src/presentation/features/splash/cubit/splash_cubit.dart';

// 2) Наши роуты

class Sabail extends StatelessWidget {
  const Sabail({super.key});

  @override
  Widget build(BuildContext context) {
    // sl уже инициализирован в main() перед runApp()
    return RepositoryProvider.value(
      // если тебе нужна "сырая" БД в каких-то низкоуровневых задачах
      value: sl<AppDatabase>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        initialRoute: Routes.splash,
        routes: {
          // SplashScreen with ViewModel
          Routes.splash: (_) => BlocProvider(
            create: (_) => sl<SplashCubit>()..init(),
            child: const SplashScreen(),
          ),

          // Home
          Routes.home: (_) => BlocProvider<HomeCubit>(
            create: (_) => sl<HomeCubit>(),
            child:
                const SabailHome(), // вот здесь возвращаем контейнер с табами
          ),

          // Quran
          // Routes.quran: (_) => ChangeNotifierProvider(
          //       create: (_) => sl<QuranViewModel>(),
          //       child: const QuranPage(),
          //     ),

          // Prayer Times
          // Routes.prayer: (_) => ChangeNotifierProvider(
          //       create: (_) => sl<PrayerViewModel>(),
          //       child: const PrayerTimesPage(),
          //     ),

          // Profile
          // Routes.profile: (_) => ChangeNotifierProvider(
          //       create: (_) => sl<ProfileViewModel>(),
          //       child: const ProfilePage(),
          //     ),
        },
      ),
    );
  }
}
