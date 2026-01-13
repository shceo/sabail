import 'package:flutter/material.dart';
import 'package:sabail/src/features/home/presentation/views/home_screen.dart';
import 'package:sabail/src/features/prayer_times/presentation/views/prayer_time.dart';
import 'package:sabail/src/features/profile/presentation/views/profile_screen.dart';
import 'package:sabail/src/features/quran/presentation/views/quran_screen.dart';

class AppRouter {
  static Map<String, WidgetBuilder> get routes => {
        HomeScreen.routeName: (context) => const HomeScreen(),
        PrayerTimesScreen.routeName: (context) => const PrayerTimesScreen(),
        QuranScreen.routeName: (context) => const QuranScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
      };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: builder, settings: settings);
    }
    return null;
  }
}
