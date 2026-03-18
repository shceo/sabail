import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sabail/src/features/prayer_times/domain/entities/prayer_day.dart';

class PrayerTimesService {
  final http.Client client;

  PrayerTimesService({http.Client? client}) : client = client ?? http.Client();

  Future<PrayerDay> fetchByCity({
    required String city,
    required String country,
  }) async {
    final uri = Uri.https('api.aladhan.com', '/v1/timingsByCity', {
      'city': city,
      'country': country,
      'method': '12',
    });
    return _request(uri);
  }

  Future<PrayerDay> fetchByCoords({
    required double latitude,
    required double longitude,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final uri = Uri.https('api.aladhan.com', '/v1/timings/$now', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'method': '12',
    });
    return _request(uri);
  }

  Future<List<PrayerDay>> fetchUpcomingByCity({
    required String city,
    required String country,
    int horizonDays = 45,
  }) async {
    final today = DateTime.now();
    final months = _monthsInRange(today, horizonDays);
    final days = <PrayerDay>[];

    for (final month in months) {
      days.addAll(
        await fetchMonthByCity(
          city: city,
          country: country,
          year: month.year,
          month: month.month,
        ),
      );
    }

    return _trimUpcomingDays(days, horizonDays);
  }

  Future<List<PrayerDay>> fetchUpcomingByCoords({
    required double latitude,
    required double longitude,
    int horizonDays = 45,
  }) async {
    final today = DateTime.now();
    final months = _monthsInRange(today, horizonDays);
    final days = <PrayerDay>[];

    for (final month in months) {
      days.addAll(
        await fetchMonthByCoords(
          latitude: latitude,
          longitude: longitude,
          year: month.year,
          month: month.month,
        ),
      );
    }

    return _trimUpcomingDays(days, horizonDays);
  }

  Future<List<PrayerDay>> fetchMonthByCity({
    required String city,
    required String country,
    required int year,
    required int month,
  }) async {
    final uri = Uri.https(
      'api.aladhan.com',
      '/v1/calendarByCity/$year/$month',
      {'city': city, 'country': country, 'method': '12'},
    );
    return _requestCalendar(uri);
  }

  Future<List<PrayerDay>> fetchMonthByCoords({
    required double latitude,
    required double longitude,
    required int year,
    required int month,
  }) async {
    final uri = Uri.https('api.aladhan.com', '/v1/calendar/$year/$month', {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'method': '12',
    });
    return _requestCalendar(uri);
  }

  Future<PrayerDay> _request(Uri uri) async {
    final res = await client.get(uri);
    if (res.statusCode != 200) {
      throw Exception('API request failed (${res.statusCode})');
    }
    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final data = json['data'] as Map<String, dynamic>;
    return _mapPrayerDay(data);
  }

  Future<List<PrayerDay>> _requestCalendar(Uri uri) async {
    final res = await client.get(uri);
    if (res.statusCode != 200) {
      throw Exception('Failed to load prayer calendar (${res.statusCode})');
    }

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final data = json['data'] as List<dynamic>;
    return data
        .map((entry) => _mapPrayerDay(entry as Map<String, dynamic>))
        .toList();
  }

  PrayerDay _mapPrayerDay(Map<String, dynamic> data) {
    final timings = data['timings'] as Map<String, dynamic>;
    final date = data['date']['gregorian']['date'] as String;
    final parts = date.split('-');
    final day = DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );

    return PrayerDay(
      date: DateTime(day.year, day.month, day.day),
      fajrMinutes: _minutes(timings['Fajr'] as String),
      dhuhrMinutes: _minutes(timings['Dhuhr'] as String),
      asrMinutes: _minutes(timings['Asr'] as String),
      maghribMinutes: _minutes(timings['Maghrib'] as String),
      ishaMinutes: _minutes(timings['Isha'] as String),
    );
  }

  int _minutes(String time) {
    final clean = time.split(' ').first;
    final pieces = clean.split(':');
    return int.parse(pieces[0]) * 60 + int.parse(pieces[1]);
  }

  List<DateTime> _monthsInRange(DateTime start, int horizonDays) {
    final normalizedStart = DateTime(start.year, start.month);
    final end = DateTime(start.year, start.month, start.day + horizonDays);
    final months = <DateTime>[];
    var cursor = normalizedStart;

    while (cursor.isBefore(DateTime(end.year, end.month + 1))) {
      months.add(cursor);
      cursor = DateTime(cursor.year, cursor.month + 1);
    }

    return months;
  }

  List<PrayerDay> _trimUpcomingDays(List<PrayerDay> days, int horizonDays) {
    final today = DateTime.now();
    final start = DateTime(today.year, today.month, today.day);
    final end = start.add(Duration(days: horizonDays));
    final upcoming =
        days.where((day) {
          final date = DateTime(day.date.year, day.date.month, day.date.day);
          return !date.isBefore(start) && date.isBefore(end);
        }).toList();

    upcoming.sort((left, right) => left.date.compareTo(right.date));
    return upcoming;
  }
}
