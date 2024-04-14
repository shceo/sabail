import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CityProvider extends ChangeNotifier {
  String _selectedCity = 'Ташкент'; 
  Box? _box;
  Future? initFuture;
  final TextEditingController _controller = TextEditingController();
  List<String> _cityNames = [];

  CityProvider() {
    initFuture = _initHiveAndLoadCityNames();
  }

  Future<void> _initHiveAndLoadCityNames() async {
    await _initHive();
    await _loadCityNames();
  }

  Future<void> _initHive() async {
    _box = await Hive.openBox('myBox');
    _selectedCity = _box!.get('selectedCity', defaultValue: 'Ташкент');
  }

  Future<void> _loadCityNames() async {
    final response = await rootBundle.loadString('assets/cities.json');
    final Map<String, dynamic> data = jsonDecode(response);
    final List<dynamic> citiesJson = data['city'];
    final List<String> cityNames =
        citiesJson.map((city) => city['name'] as String).toList();
    cityNames.sort();
    _cityNames = cityNames;
    notifyListeners();
  }

  String get selectedCity => _selectedCity;

void updateSelectedCity(String city) async {
  _selectedCity = city;
  await _box!.close();
  _box = await Hive.openBox('myBox');
  saveSelectedCity(city);
  notifyListeners(); // Добавить вызов notifyListeners()
}


  void saveSelectedCity(String city) {
    _box!.put('selectedCity', city);
  }

  List<String> get cityNames => _cityNames;

  List<String> _getFilteredCityNames(String query) {
    return _cityNames
        .where((city) => city.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
  }

  List<String> getFilteredCityNames() {
    return _getFilteredCityNames(_controller.text);
  }

  void updateSearchQuery(String query) {
    _controller.text = query;
    notifyListeners();
  }
}




