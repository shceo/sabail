// lib/src/presentation/features/home/viewmodel/home_vm.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/api/api.dart';                    // HijriApi, PrayerTimes
import '../../../../domain/entities/city.dart';             // City
import '../../../../domain/repositories/city_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final HijriApi _hijriApi;
  final PrayerTimes _prayerApi;
  final CityRepository _cityRepo;

  StreamSubscription<String>? _hijriSub;
  Timer? _clockTimer;

  /// Для таб-бар навигации
  int currentIndex = 0;

  /// Данные для UI
  String hijriDate = '';
  int monthNumber = 1;
  String currentTime = '';
  String selectedCity = '';
  List<String> prayerTimes = [
    'Fajr: --:--',
    'Dhuhr: --:--',
    'Asr: --:--',
    'Maghrib: --:--',
    'Isha: --:--',
  ];

  HomeViewModel({
    required HijriApi hijriApi,
    required PrayerTimes prayerApi,
    required CityRepository cityRepo,
  })  : _hijriApi = hijriApi,
        _prayerApi = prayerApi,
        _cityRepo = cityRepo {
    _init();
  }

  Future<void> _init() async {
    // 1) Навигация: стартовый таб = 0
    currentIndex = 0;

    // 2) Загрузить последний выбранный город
    final city = await _cityRepo.getSavedCity();
    selectedCity = city?.name ?? '';

    // 3) Запустить часы
    _startClock();

    // 4) Подписка на Hijri-дата
    _hijriSub = _hijriApi.getCurrentHijriDateStream().listen((date) {
      hijriDate = date;
      monthNumber = _parseHijriMonth(date);
      notifyListeners();
    });

    // 5) Загрузить времена молитв (если город уже выбран)
    await _loadPrayerTimes();
  }

  /// Переключить таб
  void selectTab(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void _startClock() {
    _updateTime();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTime());
  }

  void _updateTime() {
    currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    notifyListeners();
  }

  int _parseHijriMonth(String hijri) {
    try {
      final parts = hijri.split('/');
      return int.parse(parts[1]);
    } catch (_) {
      return 1;
    }
  }

  Future<void> _loadPrayerTimes() async {
    if (selectedCity.isEmpty) return;
    try {
      final raw = await _prayerApi.getPrayerTime(
        selectedCity,
        DateTime.now(),
        2,
      );
      prayerTimes = raw.split(', ').toList();
    } catch (_) {
      // оставить дефолтные
    }
    notifyListeners();
  }

  /// Вызывается из UI после выбора города
  Future<void> selectCity(String city) async {
    selectedCity = city;
    await _cityRepo.saveCity(City(id: 0, name: city));
    await _loadPrayerTimes();
    notifyListeners();
  }

  @override
  void dispose() {
    _hijriSub?.cancel();
    _clockTimer?.cancel();
    super.dispose();
  }
}
