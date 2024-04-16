
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabail/components/tabbar/tabbar_indicator.dart';
import 'package:sabail/provider/tabmodel_provider.dart';


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
            indicator: CircleTabIndicator(color: Colors.blue.shade700, radius: 3),
            dividerColor: Colors.transparent,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.blue,
            tabs: const [
              Tab(text: 'Сура',),
              Tab(text: 'Джуз'), //Апрекиация
              Tab(text: 'Страница'),
              // Tab(text: 'Любимые'),
            ],
          ),
        );
      },
    );
  }
}
