import 'package:drift/drift.dart' show Value;
import 'package:sabail/src/data/locale/app_db.dart';

import '../domain/entities/prayer_day.dart';
import 'prayer_times_service.dart';

class PrayerTimesRepository {
  final AppDatabase db;
  final PrayerTimesService service;

  PrayerTimesRepository({
    required this.db,
    required this.service,
  });

  Future<PrayerDay> getForCity({
    required String city,
    required String country,
  }) async {
    final today = DateTime.now();
    final normalized = DateTime(today.year, today.month, today.day);
    final cached = await db.getPrayerTimesByDate(normalized);
    try {
      final remote = await service.fetchByCity(city: city, country: country);
      await _replace(remote);
      return remote;
    } catch (_) {
      if (cached != null) return _mapFromDb(cached);
      rethrow;
    }
  }

  Future<PrayerDay> getForCoords({
    required double latitude,
    required double longitude,
  }) async {
    final today = DateTime.now();
    final normalized = DateTime(today.year, today.month, today.day);
    final cached = await db.getPrayerTimesByDate(normalized);
    try {
      final remote = await service.fetchByCoords(
        latitude: latitude,
        longitude: longitude,
      );
      await _replace(remote);
      return remote;
    } catch (_) {
      if (cached != null) return _mapFromDb(cached);
      rethrow;
    }
  }

  Future<void> _save(PrayerDay day) {
    return db.insertPrayerTimes(
      PrayerTimesCompanion(
        date: Value(day.date),
        fajr: Value(day.fajrMinutes),
        dhuhr: Value(day.dhuhrMinutes),
        asr: Value(day.asrMinutes),
        maghrib: Value(day.maghribMinutes),
        isha: Value(day.ishaMinutes),
      ),
    );
  }

  Future<void> _replace(PrayerDay day) async {
    await db.delete(db.prayerTimes).go();
    await _save(day);
  }

  PrayerDay _mapFromDb(PrayerTime row) {
    return PrayerDay(
      date: row.date,
      fajrMinutes: row.fajr,
      dhuhrMinutes: row.dhuhr,
      asrMinutes: row.asr,
      maghribMinutes: row.maghrib,
      ishaMinutes: row.isha,
    );
  }
}
