
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabail/components/tabbar/tabbar_indicator.dart';
import 'package:sabail/provider/tabmodel_provider.dart';
import 'package:sabail/ui/theme/app_colors.dart';


class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TabBarModel>(
      builder: (context, model, child) {
        return Padding(
          padding:const  EdgeInsets.only(top: 24),
          child: TabBar(
            onTap: (index) {
              model.currentIndex = index;
            },
            indicator: CircleTabIndicator(color: SabailColors.lightpurple, radius: 3),
            dividerColor: Colors.transparent,
            unselectedLabelColor: SabailColors.lightpurple.withOpacity(0.7), // Colors.grey
            labelColor: SabailColors.darkpurple,
            tabs: const [
              Tab(text: 'Сура',),
              Tab(text: 'Джуз'),
              // Tab(text: 'Страница'),
              // Tab(text: 'Любимые'),
            ],
          ),
        );
      },
    );
  }
}
