import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabail/src/presentation/widgets/tabbar_indicator.dart';
import 'package:sabail/src/cubit/tab_bar_cubit.dart';
import 'package:sabail/src/presentation/app/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBarCubit, int>(
      builder: (context, indexState) {
        return Padding(
          padding: const EdgeInsets.only(top: 24),
          child: TabBar(
            onTap: (index) {
              context.read<TabBarCubit>().setIndex(index);
            },
            indicator: CircleTabIndicator(
              color: SabailColors.lightpurple,
              radius: 3,
            ),
            dividerColor: Colors.transparent,
            unselectedLabelColor: SabailColors.lightpurple.withOpacity(
              0.7,
            ), // Colors.grey
            labelColor: SabailColors.darkpurple,
            tabs: const [
              Tab(text: 'Сура'),
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
