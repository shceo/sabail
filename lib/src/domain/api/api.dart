import 'dart:async';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class ApiConfig {
  final String hijriApiUrl;
  final String prayerTimesUrl;

  ApiConfig({
    this.hijriApiUrl = 'https://api.aladhan.com/v1/gToH',
    this.prayerTimesUrl = 'https://api.aladhan.com/v1/calendarByAddress',
  });
}
class HijriApi {
  final Dio dio;
  final Logger logger;
  final ApiConfig config;

  HijriApi({Dio? dio, Logger? logger, ApiConfig? config})
      : dio = dio ?? Dio(),
        logger = logger ?? Logger(),
        config = config ?? ApiConfig();

  Future<String> getCurrentHijriDate() async {
    try {
      final response = await dio.get(
        config.hijriApiUrl,
        queryParameters: {'date': DateFormat('dd-MM-yyyy').format(DateTime.now())},
      );

      final hijriData = response.data['data']['hijri'];
      final hijriYear = hijriData['year'];
      final hijriMonth = hijriData['month']['number'];
      final hijriDay = hijriData['day'];
      final monthName = getHijriMonthName(hijriMonth);

      return '$hijriDay $monthName $hijriYear';
    } catch (error, stackTrace) {
      logger.e('Failed to get hijri date', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<Map<DateTime, List<String>>> getIslamicHolidays() async {
    try {
      return {
        DateTime.utc(2025, 4, 10): ['Ид аль-Фитр'],
        DateTime.utc(2025, 6, 17): ['Ид аль-Адха'],
      };
    } catch (error, stackTrace) {
      logger.e('Failed to get Islamic holidays', error: error, stackTrace: stackTrace);
      return {};
    }
  }

  Future<DateTime> getRamadanStart() async {
  try {
    final response = await dio.get(
      config.hijriApiUrl,
      queryParameters: {'date': DateFormat('dd-MM-yyyy').format(DateTime.now())},
    );

    final hijriData = response.data['data']['hijri'];
    final hijriYear = hijriData['year'];
    final ramadanStart = await _findRamadanStartDate(hijriYear);

    return ramadanStart;
  } catch (error, stackTrace) {
    logger.e('Failed to get Ramadan start date', error: error, stackTrace: stackTrace);
    rethrow;
  }
}

Future<DateTime> _findRamadanStartDate(int year) async {
  try {
    final response = await dio.get(
      'https://api.aladhan.com/v1/gToH',  // Modify if necessary based on API response
      queryParameters: {'date': '01-01-$year'},
    );

    final hijriData = response.data['data']['hijri'];
    final ramadanMonth = hijriData['month']['number'];

    if (ramadanMonth == 9) {
      // Укажите дату начала Рамадана, например 1-й день Рамадана
      return DateTime(year, 3, 23);  // Примерная дата начала Рамадана (нужно уточнить)
    } else {
      throw Exception('Ramadan start date not available for year $year');
    }
  } catch (error, stackTrace) {
    logger.e('Error fetching Ramadan start date', error: error, stackTrace: stackTrace);
    rethrow;
  }
}

  Stream<String> getCurrentHijriDateStream() async* {
    while (true) {
      try {
        final hijriDate = await retry<String>(
          () => getCurrentHijriDate(),
          maxAttempts: 3,
          delayBetweenAttempts: const Duration(seconds: 2),
          logger: logger,
        );
        yield hijriDate;
      } catch (error) {
        logger.e('Error fetching hijri date in stream', error: error);
      }
      await Future.delayed(const Duration(hours: 1));
    }
  }

  String getHijriMonthName(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return 'Мухаррам';
      case 2:
        return 'Сафар';
      case 3:
        return 'Раби-уль-Авваль';
      case 4:
        return 'Раби-уль-Ахир';
      case 5:
        return 'Джумад-уль-Авваль';
      case 6:
        return 'Джумад-уль-Ахир';
      case 7:
        return 'Раджаб';
      case 8:
        return 'Шаабан';
      case 9:
        return 'Рамадан';
      case 10:
        return 'Шавваль';
      case 11:
        return 'Дуль-Каада';
      case 12:
        return 'Дуль-Хиджа';
      default:
        return '';
    }
  }
}


class PrayerTimes {
  final Dio dio;
  final Logger logger;
  final ApiConfig config;

  PrayerTimes({Dio? dio, Logger? logger, ApiConfig? config})
      : dio = dio ?? Dio(),
        logger = logger ?? Logger(),
        config = config ?? ApiConfig();

  /// Получить времена намаза для указанного адреса и даты.
  Future<String> getPrayerTime(String address, DateTime date, int method) async {
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final response = await dio.get(
        config.prayerTimesUrl,
        queryParameters: {
          'address': address,
          'method': method,
          'date': formattedDate,
        },
      );

      final data = response.data;
      logger.i('Response data: $data');
      final timings = data['data'][0]['timings'];

      final fajrTime = _cleanTime(timings['Fajr']);
      final dhuhrTime = _cleanTime(timings['Dhuhr']);
      final asrTime = _cleanTime(timings['Asr']);
      final maghribTime = _cleanTime(timings['Maghrib']);
      final ishaTime = _cleanTime(timings['Isha']);

      return 'Fajr: $fajrTime, Dhuhr: $dhuhrTime, Asr: $asrTime, Maghrib: $maghribTime, Isha: $ishaTime';
    } catch (error, stackTrace) {
      logger.e('Failed to get prayer time', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Новый метод для получения времени восхода и заката
  Future<Map<String, String>> getSunTimes(
      String address, DateTime date, int method) async {
    try {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      final response = await dio.get(
        config.prayerTimesUrl,
        queryParameters: {
          'address': address,
          'method': method,
          'date': formattedDate,
        },
      );

      final data = response.data;
      logger.i('Response data: $data');
      final timings = data['data'][0]['timings'];

      final sunrise = _cleanTime(timings['Sunrise']);
      final sunset = _cleanTime(timings['Sunset']);

      return {
        'sunrise': sunrise,
        'sunset': sunset,
      };
    } catch (error, stackTrace) {
      logger.e('Failed to get sun times', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  String _cleanTime(String time) {
    return time.replaceAll(RegExp(r'\s*\(\+\d+\)'), '').trim();
  }
}

/// Утилита для повторных попыток (retry)
Future<T> retry<T>(
  Future<T> Function() task, {
  int maxAttempts = 3,
  Duration delayBetweenAttempts = const Duration(seconds: 2),
  required Logger logger,
}) async {
  int attempt = 0;
  while (true) {
    attempt++;
    try {
      return await task();
    } catch (error, stackTrace) {
      logger.w('Attempt $attempt failed', error: error, stackTrace: stackTrace);
      if (attempt >= maxAttempts) {
        logger.e('Max attempts reached, rethrowing error');
        rethrow;
      }
      await Future.delayed(delayBetweenAttempts);
    }
  }
}
