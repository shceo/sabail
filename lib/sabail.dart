import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabail/domain/blocs/splash_bloc/splash_screen_bloc.dart';
import 'package:sabail/ui/routes/app_navigator.dart';

class Sabail extends StatelessWidget {
  const Sabail({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashBloc()..add(AppStarted()),
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
