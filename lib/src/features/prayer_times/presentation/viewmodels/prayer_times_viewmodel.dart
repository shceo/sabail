import 'package:flutter/material.dart';
import 'package:sabail/src/core/notifications/notification_service.dart';
import 'package:sabail/src/core/services/city_service.dart';
import 'package:sabail/src/core/services/location_service.dart';
import 'package:sabail/src/features/prayer_times/data/prayer_notification_sync_service.dart';
import 'package:sabail/src/features/prayer_times/data/prayer_times_repository.dart';
import 'package:sabail/src/features/prayer_times/domain/entities/prayer_day.dart';
import 'package:sabail/src/features/prayer_times/presentation/viewmodels/prayer_location_store.dart';

class PrayerTimesViewModel extends ChangeNotifier {
  final PrayerTimesRepository repository;
  final CityService cityService;
  final LocationService locationService;
  final NotificationService notificationService;
  final PrayerNotificationSyncService notificationSyncService;
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
    required this.notificationSyncService,
    required this.locationStore,
  }) : country = locationStore.country,
       city = locationStore.city;

  Future<void> init() async {
    await loadCountries();
    await loadCities(country);
    await loadForCity();
  }

  Future<void> loadCountries() async {
    isLoadingCities = true;
    notifyListeners();
    try {
      countries = await cityService.fetchCountries();
    } catch (_) {
      countries = const [];
    } finally {
      isLoadingCities = false;
      notifyListeners();
    }
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
      await locationStore.setManualLocation(
        countryName: country,
        cityName: city,
      );
      await _syncNotifications(
        () => notificationSyncService.syncForCity(city: city, country: country),
      );
    } catch (e) {
      error = _loadErrorMessage(
        e,
        fallback: 'Не удалось загрузить время молитв.',
      );
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
        throw Exception('Could not resolve city/country from location');
      }
    } catch (e) {
      error = _loadErrorMessage(
        e,
        fallback: 'Не удалось определить местоположение.',
      );
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
      await locationStore.setDeviceLocation(
        countryName: country,
        cityName: city,
        latitudeValue: lat,
        longitudeValue: lng,
      );
      await _syncNotifications(
        () => notificationSyncService.syncForCoords(
          latitude: lat,
          longitude: lng,
        ),
      );
    } catch (e) {
      error = _loadErrorMessage(
        e,
        fallback: 'Не удалось загрузить время молитв.',
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _syncNotifications(Future<void> Function() action) async {
    try {
      await action();
    } catch (e) {
      error = _notificationErrorMessage(e);
    }
  }

  String _notificationErrorMessage(Object error) {
    final message = error.toString();
    if (message.startsWith('Bad state: ')) {
      return message.substring('Bad state: '.length);
    }
    return 'Failed to schedule prayer notifications: $message';
  }

  String _loadErrorMessage(Object error, {required String fallback}) {
    final message = error.toString();
    final normalized = message.toLowerCase();

    if (message.startsWith('Bad state: ')) {
      return message.substring('Bad state: '.length);
    }
    if (message.startsWith('Exception: ')) {
      return message.substring('Exception: '.length);
    }
    if (normalized.contains('failed host lookup') ||
        normalized.contains('socketexception') ||
        normalized.contains('clientexception') ||
        normalized.contains('connection closed') ||
        normalized.contains('timed out')) {
      return 'Проверь подключение к интернету и попробуй снова.';
    }
    if (normalized.contains('could not resolve city/country from location')) {
      return 'Не удалось определить город и страну по геолокации.';
    }
    return fallback;
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
    if (hours == 0) return '$minutes РјРёРЅ';
    return '$hours С‡ ${minutes.toString().padLeft(2, '0')} РјРёРЅ';
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
