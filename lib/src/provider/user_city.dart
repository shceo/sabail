import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sabail/src/data/locale/db.dart';

class CityProvider extends ChangeNotifier {
  final AppDatabase _db;
  String _selectedCity = 'Ташкент';
  List<String> _cityNames = [];

  CityProvider(this._db) {
    _init();
  }

  Future<void> _init() async {
    // Если в таблице нет городов — подгрузим из assets
    final existing = await _db.getAllCities();
    if (existing.isEmpty) {
      final jsonStr = await rootBundle.loadString('assets/cities.json');
      final data = jsonDecode(jsonStr)['city'] as List;
      final names = data.map((e) => e['name'] as String).toList();
      await _db.insertCities(names);
    }
    _cityNames = await _db.getAllCities();
    _selectedCity = await _db.getSetting('selectedCity') ?? 'Ташкент';
    notifyListeners();
  }

  List<String> get cityNames => _cityNames;
  String get selectedCity => _selectedCity;

  void updateSelectedCity(String city) {
    _selectedCity = city;
    _db.setSetting('selectedCity', city);
    notifyListeners();
  }

  List<String> getFilteredCityNames(String query) {
    return _cityNames
        .where((c) => c.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
  }
}
