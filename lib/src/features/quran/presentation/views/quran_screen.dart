import 'package:flutter/material.dart';

class QuranScreen extends StatelessWidget {
  static const String routeName = '/quran';
  const QuranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Quran Screen')),
    );
  }
}