import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sabail/src/domain/blocs/splash_bloc/splash_screen_bloc.dart';
import 'package:sabail/src/ui/routes/app_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashScreenState>(
      listener: (context, state) {
        if (state is AppLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(AppRoutes.home);
          });
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration:const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splash.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Center(
                child: SpinKitSpinningLines(
                  color: Color.fromARGB(255, 87, 30, 111),
                  size: 40.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


