
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sabail/components/navbar/navbar_model.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    required this.screens,
  });

  final List<Widget> screens;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      // backgroundColor: CryptoColors.notblack,
      tabBar: CupertinoTabBar(
        // backgroundColor: CryptoColors.notblack,
        height: 70,
        items: const [
          BottomNavigationBarItem(
            icon: NavigationTabItem(
              icon: Icons.home_filled,
              active: false,
              text: 'Главная',
            ),
            activeIcon: NavigationTabItem(
              icon: Icons.home_filled,
              active: true,
              text: 'Главная',
            ),
          ),
          BottomNavigationBarItem(
            icon: NavigationTabItem(
              icon: Icons.mosque_outlined,
              active: false,
              text: 'Время молитвы',
            ),
            activeIcon: NavigationTabItem(
              icon: Icons.mosque_outlined,
              active: true,
              text: 'Время молитвы',
            ),
          ),
          BottomNavigationBarItem(
            icon: NavigationTabItem(
              icon: Icons.import_contacts_sharp,
              active: false,
              text: 'Коран',
            ),
            activeIcon: NavigationTabItem(
              icon: Icons.import_contacts_sharp,
              active: true,
              text: 'Коран',
            ),
          ),
          BottomNavigationBarItem(
            icon: NavigationTabItem(
              icon: Icons.person_outline,
              active: false,
              text: 'Профиль',
            ),
            activeIcon: NavigationTabItem(
              icon: Icons.person_outline,
              active: true,
              text: 'Профиль',
            ),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return screens[index];
          },
        );
      },
    );
  }
}
