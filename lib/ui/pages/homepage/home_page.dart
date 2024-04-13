import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sabail/provider/nav_bar_provider.dart';
import 'package:sabail/ui/pages/navbar_pages/main_page.dart';
import 'package:sabail/ui/pages/navbar_pages/prayer_times.dart';
import 'package:sabail/ui/pages/navbar_pages/profile.dart';
import 'package:sabail/ui/pages/navbar_pages/quran_page.dart';

class SabailHome extends StatelessWidget {
  const SabailHome({Key? key});

  static List<Widget> screens = const [
    MainPage(),
    PrayTimes(),
    AlQuranPage(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final navBarProvider = Provider.of<NavBarProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: navBarProvider.currentIndex,
            children: screens,
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 105,
            left: 0,
            right: 0,
            bottom: 15,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(23),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BottomAppBar(
                  padding: const EdgeInsets.only(top: 0),
                  color: Colors.transparent,
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(
                          context, 0, "assets/icons/moon.svg", 'Главная'),
                      _buildNavItem(context, 1, "assets/icons/mosque.svg",
                          'Времена молитв'),
                      _buildNavItem(
                          context, 2, "assets/icons/quran.svg", 'Аль Коран'),
                      _buildNavItem(
                          context, 3, "assets/icons/profile.svg", 'Профиль'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



    Widget _buildNavItem(
    BuildContext context, int index, String icon, String label) {
  final navBarProvider = Provider.of<NavBarProvider>(context);
  final color = navBarProvider.currentIndex == index
      ? Colors.purple.shade700
      : Colors.grey;

  return Expanded(
    child: InkWell(
      onTap: (){
          navBarProvider.changeIndex(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.translate(
            offset: Offset(0, -13), 
            child: SvgPicture.asset(
              icon,
              width: 26,
              height: 23,
              color: color,
            ),
          ),
          SizedBox(height: 10),
          Transform.translate(
            offset: Offset(0, -12),
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

}

