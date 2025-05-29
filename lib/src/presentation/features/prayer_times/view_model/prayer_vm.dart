import 'package:flutter/material.dart';
import '../../../../domain/api/api.dart'; // Класс PrayerTimes
import '../../../../domain/repositories/city_repository.dart';
// lib/src/presentation/features/prayer_times/viewmodel/prayer_vm.dart

class PrayerViewModel extends ChangeNotifier {
  final PrayerTimes _prayerApi;
  final CityRepository _cityRepo;

  bool isLoading = false;
  String? errorMessage;
  List<String> prayerTimes = [];

  /// Добавляем поля для солнечных времён
  DateTime? sunrise;
  DateTime? sunset;

  PrayerViewModel({
    required PrayerTimes prayerApi,
    required CityRepository cityRepo,
  })  : _prayerApi = prayerApi,
        _cityRepo = cityRepo;

  /// Пускаем единый метод, который грузит и молитвенные времена, и sunTimes
  Future<void> loadAllData() async {
    isLoading = true;
    errorMessage = null;
    prayerTimes = [];
    sunrise = null;
    sunset = null;
    notifyListeners();

    try {
      final city = await _cityRepo.getSavedCity();
      if (city == null) {
        errorMessage = 'Город не выбран';
        return;
      }
      // 1) молитвенные времена
      final rawPrayers = await _prayerApi.getPrayerTime(
        city.name,
        DateTime.now(),
        2,
      );
      prayerTimes = rawPrayers.split(', ').toList();

      // 2) времена восхода/заката
      final rawSun = await _prayerApi.getSunTimes(
        city.name,
        DateTime.now(),
        1,
      );
      sunrise = _parseTime(rawSun['sunrise']!);
      sunset = _parseTime(rawSun['sunset']!);
    } catch (e) {
      errorMessage = 'Не удалось загрузить данные';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  DateTime _parseTime(String timeStr) {
    final now = DateTime.now();
    final parts = timeStr.split(':');
    return DateTime(
        now.year, now.month, now.day, int.parse(parts[0]), int.parse(parts[1]));
  }
}
