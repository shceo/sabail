import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:sabail/firebase_options.dart';
import 'package:sabail/src/presentation/app/injector.dart';
import 'package:sabail/src/domain/blocs/splash_bloc/splash_screen_bloc.dart';
import 'package:sabail/src/sabail.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await init();  // инициализируем GetIt (AppDatabase, DAO, репы, usecases, VM и т.п.)

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      // сюда же шлите логи в ваш сервис
    };

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<SplashBloc>(
            create: (_) => sl<SplashBloc>()..add(AppStarted()),
          ),
        ],
        child: const Sabail(),  // здесь ваш корневой виджет Sabail
      ),
    );
  }, (error, stack) {
    debugPrint('Uncaught zone error: $error\n$stack');
  });
}
