import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabail/domain/blocs/splash_bloc/splash_screen_bloc.dart';
import 'package:sabail/sabail.dart';

void main() async{
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => SplashBloc()..add(AppStarted()),
    ),
  ], child: const Sabail()));
}
