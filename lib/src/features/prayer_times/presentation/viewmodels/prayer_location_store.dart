import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerLocationStore extends ChangeNotifier {
  static const _countryKey = 'prayer_location_country';
  static const _cityKey = 'prayer_location_city';
  static const _latitudeKey = 'prayer_location_latitude';
  static const _longitudeKey = 'prayer_location_longitude';

  String country = 'Qatar';
  String city = 'Doha';
  double? latitude;
  double? longitude;
  bool hasSavedLocation = false;

  late final SharedPreferences _preferences;

  bool get hasCoordinates => latitude != null && longitude != null;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    country = _preferences.getString(_countryKey) ?? country;
    city = _preferences.getString(_cityKey) ?? city;
    latitude = _preferences.getDouble(_latitudeKey);
    longitude = _preferences.getDouble(_longitudeKey);
    hasSavedLocation =
        _preferences.containsKey(_countryKey) &&
        _preferences.containsKey(_cityKey);
  }

  Future<void> setManualLocation({
    required String countryName,
    required String cityName,
  }) async {
    country = countryName;
    city = cityName;
    latitude = null;
    longitude = null;
    hasSavedLocation = true;
    await _persist();
    notifyListeners();
  }

  Future<void> setDeviceLocation({
    required String countryName,
    required String cityName,
    required double latitudeValue,
    required double longitudeValue,
  }) async {
    country = countryName;
    city = cityName;
    latitude = latitudeValue;
    longitude = longitudeValue;
    hasSavedLocation = true;
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    await _preferences.setString(_countryKey, country);
    await _preferences.setString(_cityKey, city);

    if (latitude == null || longitude == null) {
      await _preferences.remove(_latitudeKey);
      await _preferences.remove(_longitudeKey);
      return;
    }

    await _preferences.setDouble(_latitudeKey, latitude!);
    await _preferences.setDouble(_longitudeKey, longitude!);
  }
}
