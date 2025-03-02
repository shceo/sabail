import 'dart:convert';
import 'package:http/http.dart' as http;

class QuranApiService {
  static const String baseUrl = 'https://api.quran.com/api/v4';
  static Future<List<Surah>> fetchChapters() async {
    final url = Uri.parse('$baseUrl/chapters');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> chaptersData = jsonData['chapters'];
      return chaptersData.map((json) => Surah.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка при получении сур: ${response.statusCode} ${response.body}');
    }
  }
}

class Surah {
  final int id;
  final String nameArabic;
  final String nameSimple;
  final int versesCount;

  Surah({
    required this.id,
    required this.nameArabic,
    required this.nameSimple,
    required this.versesCount,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      id: json['id'],
      nameArabic: json['name_arabic'],
      nameSimple: json['name_simple'],
      versesCount: json['verses_count'],
    );
  }
}

Future<void> printSurahs() async {
  try {
    final surahs = await QuranApiService.fetchChapters();
    for (var surah in surahs) {
      print('${surah.id}: ${surah.nameSimple} (${surah.nameArabic}) - Аятов: ${surah.versesCount}');
    }
  } catch (e) {
    print('Ошибка: $e');
  }
}

