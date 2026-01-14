import 'package:flutter/material.dart';
import 'package:sabail/src/features/home/presentation/views/feature_detail_screen.dart';
import 'package:sabail/src/features/home/presentation/views/home_screen.dart';
import 'package:sabail/src/features/prayer_times/presentation/views/prayer_time.dart';
import 'package:sabail/src/features/profile/presentation/views/profile_screen.dart';
import 'package:sabail/src/features/profile/presentation/views/edit_profile_screen.dart';
import 'package:sabail/src/features/profile/presentation/views/donation_history_screen.dart';
import 'package:sabail/src/features/profile/presentation/views/privacy_screen.dart';
import 'package:sabail/src/features/quran/presentation/views/quran_screen.dart';
import 'package:sabail/src/features/quran/presentation/views/quran_tool_screen.dart';
import 'package:sabail/src/features/settings/presentation/views/settings_screen.dart';

class AppRouter {
  static Map<String, WidgetBuilder> get routes => {
        HomeScreen.routeName: (context) => const HomeScreen(),
        PrayerTimesScreen.routeName: (context) => const PrayerTimesScreen(),
        QuranScreen.routeName: (context) => const QuranScreen(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
        SettingsScreen.routeName: (context) => const SettingsScreen(),
        EditProfileScreen.routeName: (context) => const EditProfileScreen(),
        DonationHistoryScreen.routeName: (context) =>
            const DonationHistoryScreen(),
        PrivacyScreen.routeName: (context) => const PrivacyScreen(),
      };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == FeatureDetailScreen.routeName) {
      final args = settings.arguments as FeatureDetailArgs?;
      final definition = FeatureCatalog.byId(args?.id ?? 'kalma');
      return MaterialPageRoute(
        builder: (context) => FeatureDetailScreen(definition: definition),
        settings: settings,
      );
    }
    if (settings.name == QuranToolScreen.routeName) {
      final args = settings.arguments as QuranToolArgs?;
      final definition = QuranToolCatalog.byId(args?.id ?? 'bookmarks');
      return MaterialPageRoute(
        builder: (context) => QuranToolScreen(definition: definition),
        settings: settings,
      );
    }
    final builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: builder, settings: settings);
    }
    return null;
  }
}
