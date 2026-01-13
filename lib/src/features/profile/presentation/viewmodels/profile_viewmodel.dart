import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  String name = 'Aisha Khan';
  String city = 'Doha, Qatar';
  double donated = 245.50;
  int streak = 7;
  bool notificationsEnabled = true;
  bool locationEnabled = true;

  void toggleNotifications(bool value) {
    notificationsEnabled = value;
    notifyListeners();
  }

  void toggleLocation(bool value) {
    locationEnabled = value;
    notifyListeners();
  }

  void refreshProfile() {
    notifyListeners();
  }
}
