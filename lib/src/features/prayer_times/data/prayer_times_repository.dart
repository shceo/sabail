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

  Future<PrayerDay> getForDate(DateTime date) async {
    final normalized = DateTime(date.year, date.month, date.day);
    final cached = await db.getPrayerTimesByDate(normalized);
    if (cached != null) {
      return _mapFromDb(cached);
    }

    final remote = await service.fetchFor(normalized);
    await _save(remote);
    return remote;
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
