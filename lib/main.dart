import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:sabail/firebase_options.dart';
import 'package:sabail/src/presentation/app/injector.dart';
import 'package:sabail/src/presentation/features/splash/view_model/splash_view_model.dart';
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
      ChangeNotifierProvider(
        create: (_) => sl<SplashViewModel>()..init(),
        child: const Sabail(),
      ),
    );
  }, (error, stack) {
    debugPrint('Uncaught zone error: $error\n$stack');
  });
}
