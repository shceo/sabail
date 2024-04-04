import 'package:flutter/material.dart';
import 'package:sabail/components/navbar/nav_bar.dart';
import 'package:sabail/ui/pages/appbody/sabail_bod.dart';
import 'package:sabail/ui/pages/navbar_pages/main_page.dart';
import 'package:sabail/ui/pages/navbar_pages/prayer_times.dart';
import 'package:sabail/ui/pages/navbar_pages/profile.dart';
import 'package:sabail/ui/pages/navbar_pages/quran_page.dart';
// import 'package:sabail/ui/theme/app_colors.dart';

class SabailHome extends StatelessWidget {
  const SabailHome({super.key});

  static List<Widget> screens = [
    const MainPage(),
    const PrayTimes(),
    const AlQuranPage(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: SabailColors.notwhite,
      body: const SabailBody(),
      bottomNavigationBar:   TabBarWidget(screens: screens),
        );
      
  }
}
