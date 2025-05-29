// lib/src/presentation/features/home/view/sabail_home.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sabail/src/presentation/features/home/view_model/home_vm.dart';
import 'package:sabail/src/presentation/features/prayer_times/view/prayer_times.dart';
import 'package:sabail/src/presentation/features/profile/view/profile.dart';
import 'package:sabail/src/presentation/features/quran/view/quran_page.dart';


import '../view/home_screen.dart';
class SabailHome extends StatelessWidget {
  const SabailHome({Key? key}) : super(key: key);

  static const List<Widget> screens = [
    HomeScreen(),
    PrayerTimesPage(),
    AlQuranPage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          IndexedStack(
            index: vm.currentIndex,
            children: screens,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: const FloatingNavBar(),
          ),
        ],
      ),
    );
  }
}

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({Key? key}) : super(key: key);

  Widget _navItem(BuildContext context, int index, String asset, String label) {
    final vm = context.watch<HomeViewModel>();
    final selected = vm.currentIndex == index;
    final color = selected ? Colors.purple.shade700 : Colors.grey;

    return Expanded(
      child: InkWell(
        onTap: () => vm.selectTab(index),
        borderRadius: BorderRadius.circular(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(asset, width: 26, height: 23, color: color),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 11, color: color)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(30),
      color: Colors.transparent,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            _navItem(context, 0, 'assets/icons/moon.svg', 'Главная'),
            _navItem(context, 1, 'assets/icons/mosque.svg', 'Время молитв'),
            _navItem(context, 2, 'assets/icons/quran.svg', 'Аль Коран'),
            _navItem(context, 3, 'assets/icons/profile.svg', 'Профиль'),
          ],
        ),
      ),
    );
  }
}
