import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:sabail/firebase_options.dart';
import 'package:sabail/src/data/locale/db.dart';
import 'package:sabail/src/domain/blocs/splash_bloc/splash_screen_bloc.dart';
import 'package:sabail/src/provider/user_city.dart';
import 'package:sabail/src/sabail.dart';

Future<void> main() async {
  // В зоне runZonedGuarded мы сможем поймать все асинхронные ошибки
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Перехват ошибок Flutter framework
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      // Здесь можно отправить стектрейс в свой сервис логирования
      // Например: MyErrorService.reportError(details.exception, details.stack);
    };

    // Инициализируем Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Фиксируем ориентацию экрана
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Создаём единый экземпляр базы
    final db = AppDatabase();

    // Передаём БД в провайдер городов
    final cityProvider = CityProvider(db);

    runApp(
      MultiProvider(
        providers: [
          Provider<AppDatabase>.value(value: db),
          ChangeNotifierProvider<CityProvider>.value(value: cityProvider),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SplashBloc>(
              create: (_) => SplashBloc()..add(AppStarted()),
            ),
          ],
          child: const Sabail(),
        ),
      ),
    );
  }, (Object error, StackTrace stack) {
    // Логируем все необработанные ошибки в зоне
    // Можно отправить в аналитический/ошибко-репортинг сервис
    // Например: MyErrorService.reportError(error, stack);
    debugPrint('Uncaught zone error: $error\n$stack');
  });
}
