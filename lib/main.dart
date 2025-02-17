import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sabail/src/domain/blocs/splash_bloc/splash_screen_bloc.dart';
import 'package:sabail/src/domain/notifications/local_notifications.dart';
import 'package:sabail/src/provider/user_city.dart';
import 'package:sabail/src/sabail.dart';

CityProvider cityProvider = CityProvider();

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    
    Hive.initFlutter().then((_) {
      return SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
      );
    }).then((_) {
      return cityProvider.initFuture;
    }).then((_) {
      return schedulePrayerTimeNotifications(cityProvider.selectedCity);
    }).then((_) {
      runApp(
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SplashBloc()..add(AppStarted()),
            ),
          ],
          child: const Sabail(),
        ),
      );
    });
  }, (error, stack) {
    print('Uncaught error: $error');
    print('Stack trace: $stack');
  });
}
