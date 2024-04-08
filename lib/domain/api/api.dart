import 'dart:async';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class HijriApi {
  final Dio _dio = Dio();

  /// Получить текущую дату хиджри.
  Future<String> getCurrentHijriDate() async {
    try {
      final response = await _dio.get(
        'https://api.aladhan.com/v1/gToH',
        queryParameters: {
          'date': DateFormat('dd-MM-yyyy').format(DateTime.now()),
        },
      );

      final hijriData = response.data['data']['hijri'];
      final hijriYear = hijriData['year'];
      final hijriMonth = hijriData['month']['number'];
      final hijriDay = hijriData['day'];
      final monthName = getHijriMonthName(hijriMonth);

      final hijriDate = '$hijriDay $monthName $hijriYear'; 
      return hijriDate;
    } catch (error) {
      throw Exception('Failed to get hijri date: $error');
    }
  }

  Stream<String> getCurrentHijriDateStream() async* {
    
    try {
      while (true) {
        final hijriDate = await getCurrentHijriDate();
        yield hijriDate;
        await Future.delayed(const Duration(hours: 1));
      }
    } catch (error) {
      print('Error fetching hijri date: $error');
      await Future.delayed(const Duration(minutes: 5));
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
