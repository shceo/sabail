import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sabail/domain/blocs/splash_bloc/splash_screen_bloc.dart';
import 'package:sabail/domain/notifications/local_notifications.dart';
import 'package:sabail/provider/user_city.dart';
import 'package:sabail/sabail.dart';

// Глобальная переменная для хранения выбранного города
CityProvider cityProvider = CityProvider();

void main() async {
  // Инициализация Hive и остальных компонентов
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();

  // Получение выбранного города
  await cityProvider.initFuture;

  // Установка уведомлений о времени молитвы для выбранного города
  await schedulePrayerTimeNotifications(cityProvider.selectedCity);

  // Запуск приложения
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SplashBloc()..add(AppStarted()),
      ),
    ],
    child: const Sabail(),
  ));
}
