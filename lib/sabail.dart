import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sabail/provider/image_picker_provider.dart';

import 'package:sabail/provider/nav_bar_provider.dart';
import 'package:sabail/provider/prayerpage_provider.dart';
import 'package:sabail/provider/tabmodel_provider.dart';
import 'package:sabail/provider/time_provider.dart';
import 'package:sabail/provider/user_city.dart';
import 'package:sabail/ui/pages/navbar_pages/prayer_times.dart';

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
        ChangeNotifierProvider(create: (context) => HijriDateModel()),
       
        ChangeNotifierProvider(create: (context) => ImageNotifier()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppNavigator.router,
        theme: ThemeData(useMaterial3: true),
      ),
    );
  }
}
