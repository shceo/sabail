import 'package:flutter/material.dart';
import 'package:sabail/src/features/prayer_times/data/prayer_times_repository.dart';
import 'package:sabail/src/features/prayer_times/domain/entities/prayer_day.dart';

class PrayerTimesViewModel extends ChangeNotifier {
  final PrayerTimesRepository repository;

  bool isLoading = false;
  PrayerDay? day;
  String? error;

  PrayerTimesViewModel(this.repository);

  Future<void> loadForDate(DateTime date) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      day = await repository.getForDate(date);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
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
    final remaining = _timeToNextPrayer();
    return remaining != null ? remaining.$1 : null;
  }

  String? timeUntilNextPrayer() {
    final remaining = _timeToNextPrayer();
    if (remaining == null) return null;
    final duration = remaining.$2;
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
