import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sabail/src/features/prayer_times/domain/entities/prayer_day.dart';

class PrayerTimesService {
  final http.Client client;

  PrayerTimesService({http.Client? client})
      : client = client ?? http.Client();

  Future<PrayerDay> fetchByCity({
    required String city,
    required String country,
  }) async {
    final uri = Uri.https(
      'api.aladhan.com',
      '/v1/timingsByCity',
      {
        'city': city,
        'country': country,
        'method': '12',
      },
    );
    return _request(uri);
  }

  Future<PrayerDay> fetchByCoords({
    required double latitude,
    required double longitude,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final uri = Uri.https(
      'api.aladhan.com',
      '/v1/timings/$now',
      {
        'latitude': '$latitude',
        'longitude': '$longitude',
        'method': '12',
      },
    );
    return _request(uri);
  }

  Future<PrayerDay> _request(Uri uri) async {
    final res = await client.get(uri);
    if (res.statusCode != 200) {
      throw Exception('Ошибка запроса к API (${res.statusCode})');
    }
    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final data = json['data'] as Map<String, dynamic>;
    final timings = data['timings'] as Map<String, dynamic>;
    final date = data['date']['gregorian']['date'] as String;
    final parts = date.split('-');
    final day = DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );

    int minutes(String time) {
      final clean = time.split(' ').first;
      final pieces = clean.split(':');
      return int.parse(pieces[0]) * 60 + int.parse(pieces[1]);
    }

    return PrayerDay(
      date: DateTime(day.year, day.month, day.day),
      fajrMinutes: minutes(timings['Fajr']),
      dhuhrMinutes: minutes(timings['Dhuhr']),
      asrMinutes: minutes(timings['Asr']),
      maghribMinutes: minutes(timings['Maghrib']),
      ishaMinutes: minutes(timings['Isha']),
    );
  }
}
