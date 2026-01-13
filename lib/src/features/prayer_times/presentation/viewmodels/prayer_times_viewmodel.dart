import 'package:flutter/material.dart';
import 'package:sabail/src/core/notifications/notification_service.dart';
import 'package:sabail/src/core/services/city_service.dart';
import 'package:sabail/src/core/services/location_service.dart';
import 'package:sabail/src/features/prayer_times/data/prayer_times_repository.dart';
import 'package:sabail/src/features/prayer_times/domain/entities/prayer_day.dart';
import 'package:sabail/src/features/prayer_times/presentation/viewmodels/prayer_location_store.dart';

class PrayerTimesViewModel extends ChangeNotifier {
  final PrayerTimesRepository repository;
  final CityService cityService;
  final LocationService locationService;
  final NotificationService notificationService;
  final PrayerLocationStore locationStore;

  bool isLoading = false;
  bool isLoadingCities = false;
  PrayerDay? day;
  String? error;

  String country;
  String city;
  List<String> countries = [];
  List<String> cities = [];

  PrayerTimesViewModel({
    required this.repository,
    required this.cityService,
    required this.locationService,
    required this.notificationService,
    required this.locationStore,
  })  : country = locationStore.country,
        city = locationStore.city;

  Future<void> init() async {
    await loadCountries();
    await loadCities(country);
    await loadForCity();
  }

  Future<void> loadCountries() async {
    isLoadingCities = true;
    notifyListeners();
    countries = await cityService.fetchCountries();
    isLoadingCities = false;
    notifyListeners();
  }

  Future<void> loadCities(String countryName) async {
    isLoadingCities = true;
    notifyListeners();
    try {
      cities = await cityService.fetchCities(countryName);
      if (!cities.contains(city)) {
        city = cities.isNotEmpty ? cities.first : city;
      }
      country = countryName;
    } finally {
      isLoadingCities = false;
      notifyListeners();
    }
  }

  Future<void> selectCity(String newCity) async {
    city = newCity;
    notifyListeners();
    await loadForCity();
  }

  Future<void> loadForCity() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      day = await repository.getForCity(city: city, country: country);
      locationStore.setLocation(countryName: country, cityName: city);
      await _scheduleAzan(day!);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> useCurrentLocation() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final position = await locationService.currentPosition();
      final place = await locationService.resolvePlace(position);
      final resolvedCity = place?.locality ?? place?.administrativeArea;
      final resolvedCountry = place?.country;
      if (resolvedCity != null && resolvedCountry != null) {
        city = resolvedCity;
        country = resolvedCountry;
        await loadForCoords(position.latitude, position.longitude);
        await loadCities(country);
      } else {
        throw Exception('Не удалось определить город/страну');
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadForCoords(double lat, double lng) async {
    isLoading = true;
    notifyListeners();
    try {
      day = await repository.getForCoords(latitude: lat, longitude: lng);
      locationStore.setLocation(countryName: country, cityName: city);
      await _scheduleAzan(day!);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _scheduleAzan(PrayerDay day) async {
    await notificationService.cancelAll();
    final date = DateTime.now();
    final times = [
      ('Fajr', day.fajrMinutes),
      ('Dhuhr', day.dhuhrMinutes),
      ('Asr', day.asrMinutes),
      ('Maghrib', day.maghribMinutes),
      ('Isha', day.ishaMinutes),
    ];
    var id = 1;
    for (final entry in times) {
      await notificationService.scheduleDailyAzan(
        id: id++,
        date: date,
        minutesFromMidnight: entry.$2,
        title: entry.$1,
      );
    }
  }

  TimeOfDay timeOf(String key) {
    final minutes = day?.getMinuteFor(key) ?? 0;
    return TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
  }

  String formatted(TimeOfDay time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String? nextPrayerLabel() {
    return _timeToNextPrayer()?.$1;
  }

  String? timeUntilNextPrayer() {
    final duration = _timeToNextPrayer()?.$2;
    if (duration == null) return null;
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours == 0) return '$minutes мин';
    return '$hours ч ${minutes.toString().padLeft(2, '0')} мин';
  }

  (String, Duration)? _timeToNextPrayer() {
    if (day == null) return null;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final entries = <String, int>{
      'Fajr': day!.fajrMinutes,
      'Dhuhr': day!.dhuhrMinutes,
      'Asr': day!.asrMinutes,
      'Maghrib': day!.maghribMinutes,
      'Isha': day!.ishaMinutes,
    };

    for (final entry in entries.entries) {
      final target = today.add(Duration(minutes: entry.value));
      if (target.isAfter(now)) {
        return (entry.key, target.difference(now));
      }
    }
    return null;
  }
}
