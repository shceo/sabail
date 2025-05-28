import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sabail/src/data/locale/db.dart'; // <- AppDatabase
import 'package:sabail/src/provider/nav_bar_provider.dart';
import 'package:sabail/src/provider/time_provider.dart';
import 'package:sabail/src/provider/user_city.dart'; // <- CityProvider(db)
import 'package:sabail/src/provider/tabmodel_provider.dart';
import 'package:sabail/src/provider/prayerpage_provider.dart'; // <- HijriDateModel?
import 'package:sabail/src/provider/image_picker_provider.dart'; // <- ImageNotifier(db)
import 'package:sabail/src/provider/surah_cache_provider.dart';
import 'package:sabail/src/ui/routes/app_navigator.dart';

class Sabail extends StatelessWidget {
  const Sabail({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavBarProvider()),
        ChangeNotifierProvider(create: (_) => TimeProvider()),

        // ТУТ ПЕРЕДАЁМ БД в CityProvider
        ChangeNotifierProvider(
          create: (context) => CityProvider(context.read<AppDatabase>()),
        ),

        ChangeNotifierProvider(create: (_) => TabBarModel()),
        ChangeNotifierProvider(create: (_) => HijriDateModel()),

        // И ТУТ — в ImageNotifier
        ChangeNotifierProvider(
          create: (context) => ImageNotifier(context.read<AppDatabase>()),
        ),

        ChangeNotifierProvider(create: (_) => SurahCacheProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppNavigator.router,
        theme: ThemeData(useMaterial3: true),
      ),
    );
  }
}
