import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2FC07F),
      body: Stack(
        children: [
          // Растянутый подложечный ассет
          Positioned.fill(
            child: Image.asset('assets/images/splash.png', fit: BoxFit.cover),
          ),
        
        ],
      ),
    );
  }
}
