import 'package:flutter/material.dart';

class PrayerTimesScreen extends StatelessWidget {
  static const String routeName = '/prayer_times';
  const PrayerTimesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Prayer Times Screen')),
    );
  }
}
