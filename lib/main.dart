import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sabail/src/domain/blocs/splash_bloc/splash_screen_bloc.dart';
import 'package:sabail/src/provider/user_city.dart';
import 'package:sabail/src/sabail.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  final cityProvider = CityProvider();
  await cityProvider.initFuture;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: cityProvider),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SplashBloc()..add(AppStarted()),
          ),
        ],
        child: const Sabail(),
      ),
    ),
  );
}
