import 'dart:async';
import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier {
  bool _loaded = false;
  bool get loaded => _loaded;

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 8));
    _loaded = true;
    notifyListeners();
  }
}
