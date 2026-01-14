// File: lib/app.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabail/src/core/routes/app_router.dart';
import 'package:sabail/src/core/widgets/liquid_nav_bar.dart';
import 'package:sabail/src/features/home/presentation/views/home_screen.dart';
import 'package:sabail/src/features/prayer_times/presentation/views/prayer_time.dart';
import 'package:sabail/src/features/profile/presentation/views/profile_screen.dart';
import 'package:sabail/src/features/quran/presentation/views/quran_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    HomeScreen(),
    PrayerTimesScreen(),
    QuranScreen(),
    ProfileScreen(),
  ];
  static const List<LiquidNavItem> _navItems = [
    LiquidNavItem(icon: FontAwesomeIcons.house, label: 'Home'),
    LiquidNavItem(icon: FontAwesomeIcons.mosque, label: 'Prayer'),
    LiquidNavItem(icon: FontAwesomeIcons.bookQuran, label: 'Quran'),
    LiquidNavItem(icon: FontAwesomeIcons.user, label: 'Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Важно: MaterialApp даёт Directionality, Theme и т.п.
    return MaterialApp(
      title: 'Sabail',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: AppRouter.routes,
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: Scaffold(
        extendBody: true,
        body: _screens[_selectedIndex],
        bottomNavigationBar: SafeArea(
          top: false,
          child: LiquidNavBar(
            currentIndex: _selectedIndex,
            items: _navItems,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
