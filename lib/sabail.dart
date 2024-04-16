import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:sabail/provider/nav_bar_provider.dart';
import 'package:sabail/provider/tabmodel_provider.dart';
import 'package:sabail/provider/time_provider.dart';
import 'package:sabail/provider/user_city.dart';
import 'package:sabail/ui/routes/app_navigator.dart';

class Sabail extends StatelessWidget {
  const Sabail({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TimeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TabBarModel(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppNavigator.router,
        theme: ThemeData(useMaterial3: true),
      ),
    );
  }
}
