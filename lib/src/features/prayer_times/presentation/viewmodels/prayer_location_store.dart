import 'package:flutter/material.dart';

class PrayerLocationStore extends ChangeNotifier {
  String country = 'Qatar';
  String city = 'Doha';

  void setLocation({required String countryName, required String cityName}) {
    country = countryName;
    city = cityName;
    notifyListeners();
  }
}
