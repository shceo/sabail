import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeProvider extends ChangeNotifier {
  String currentTime = DateFormat.Hms().format(DateTime.now());

  TimeProvider() {
    updateTimeEverySecond();
  }

  void updateTimeEverySecond() {
    Future.delayed(const Duration(seconds: 1), () {
      currentTime = DateFormat.Hms().format(DateTime.now());
      notifyListeners();
      updateTimeEverySecond();
    });
  }
}
