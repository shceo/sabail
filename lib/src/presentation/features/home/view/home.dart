import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sabail/src/provider/nav_bar_provider.dart';
import 'package:sabail/src/presentation/features/home/view/home_screen.dart';
import 'package:sabail/src/ui/pages/navbar_pages/prayer_times.dart';
import 'package:sabail/src/ui/pages/navbar_pages/profile.dart';
import 'package:sabail/src/ui/pages/navbar_pages/quran_page.dart';

class SabailHome extends StatelessWidget {
  const SabailHome({Key? key}) : super(key: key);

  static const List<Widget> screens = [
    MainPage(),
    PrayTimes(),
    AlQuranPage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final navBarProvider = Provider.of<NavBarProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          IndexedStack(
            index: navBarProvider.currentIndex,
            children: screens,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: FloatingNavBar(),
          ),
        ],
      ),
    );
  }
}

class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navBarProvider = Provider.of<NavBarProvider>(context);
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(context, 0, "assets/icons/moon.svg", "Главная"),
            _buildNavItem(context, 1, "assets/icons/mosque.svg", "Время молитв"),
            _buildNavItem(context, 2, "assets/icons/quran.svg", "Аль Коран"),
            _buildNavItem(context, 3, "assets/icons/profile.svg", "Профиль"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, int index, String icon, String label) {
    final navBarProvider = Provider.of<NavBarProvider>(context);
    final bool isSelected = navBarProvider.currentIndex == index;
    final color = isSelected ? Colors.purple.shade700 : Colors.grey;
    return Expanded(
      child: InkWell(
        onTap: () => navBarProvider.changeIndex(index),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                icon,
                width: 26,
                height: 23,
                color: color,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(fontSize: 11, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
