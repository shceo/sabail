import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class HijriApi {
  final Dio _dio = Dio();

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

      final hijriDate = '$hijriDay-$hijriMonth-$hijriYear';
      return hijriDate;
    } catch (error) {
      throw Exception('Failed to get hijri date: $error');
    }
  }
}
