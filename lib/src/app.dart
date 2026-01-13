// File: lib/app.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabail/src/core/routes/app_router.dart';
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.teal,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.mosque),
                  label: 'Prayer',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.bookQuran),
                  label: 'Quran',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.user),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
