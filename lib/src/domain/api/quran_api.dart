import 'dart:convert';
import 'package:http/http.dart' as http;

class QuranApiService {
  static const String baseUrl = 'api.quran.com';

  /// Получает список сур (глав) через endpoint /api/v4/chapters
  static Future<List<Surah>> fetchChapters() async {
    final url = Uri.https(baseUrl, '/api/v4/chapters');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final chaptersData = jsonData['chapters'];
      List<dynamic> list;
      if (chaptersData is List) {
        list = chaptersData;
      } else if (chaptersData is Map) {
        list = chaptersData.values.toList();
      } else {
        throw Exception('Unexpected format for chapters');
      }
      return list.map((json) => Surah.fromJson(json)).toList();
    } else {
      throw Exception(
          'Ошибка при получении сур: ${response.statusCode} ${response.body}');
    }
  }

  /// Получает список джузов с объединением информации: для каждого джуза возвращает номера сур.
  static Future<List<JuzDetail>> fetchJuzDetails() async {
    final url = Uri.https(baseUrl, '/api/v4/juzs');
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Ошибка при получении джузов: ${response.statusCode} ${response.body}');
    }
    final jsonData = json.decode(response.body);
    final juzsData = jsonData['juzs'];
    if (juzsData is! List) {
      throw Exception('Unexpected format for juzs');
    }
    // Группируем по juz_number и извлекаем номера сур из ключей verse_mapping
    Map<int, Set<int>> grouping = {};
    for (var item in juzsData) {
      if (item is Map<String, dynamic>) {
        final int juzNum = item["juz_number"];
        final dynamic verseMapping = item["verse_mapping"];
        if (verseMapping is Map) {
          Set<int> surahs = verseMapping.keys
              .map((key) => int.tryParse(key) ?? 0)
              .where((v) => v != 0)
              .toSet();
          if (grouping.containsKey(juzNum)) {
            grouping[juzNum]!.addAll(surahs);
          } else {
            grouping[juzNum] = surahs;
          }
        }
      }
    }
    List<JuzDetail> details = [];
    grouping.forEach((juzNum, surahSet) {
      var surahList = surahSet.toList()..sort();
      details.add(JuzDetail(juzNumber: juzNum, surahNumbers: surahList));
    });
    details.sort((a, b) => a.juzNumber.compareTo(b.juzNumber));
    return details;
  }

  /// Получает список стихов для заданной суры через endpoint /api/v4/quran/verses/by_chapter.
  /// Параметры:
  /// - language: язык перевода (например, "en" или "ru")
  /// - translationId: id выбранного перевода (например, 131 для enSaheeh или другой для русского)
  /// - per_page: '300' для загрузки всех стихов суры
  static Future<List<Verse>> fetchSurahVerses(
    int chapterNumber, {
    String language = "en",
    int translationId = 131,
  }) async {
    final queryParameters = {
      'chapter_number': chapterNumber.toString(),
      'language': language,
      'fields': 'text_uthmani,verse_key,chapter_id,verse_number',
      'translations': translationId.toString(),
      'per_page': '300',
      'page': '1',
    };
    final url = Uri.https(baseUrl, '/api/v4/quran/verses/by_chapter', queryParameters);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final versesData = jsonData['verses'];
      if (versesData is List) {
        return versesData.map((json) => Verse.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected format for verses: ${versesData.runtimeType}');
      }
    } else {
      throw Exception('Error fetching verses: ${response.statusCode} ${response.body}');
    }
  }

  /// Получает список доступных переводов через endpoint /api/v4/resources/translations
  static Future<List<Translation>> fetchTranslations({String language = "en"}) async {
    final queryParameters = {
      'language': language,
    };
    final url = Uri.https(baseUrl, '/api/v4/resources/translations', queryParameters);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final translationsData = jsonData['translations'];
      if (translationsData is List) {
        return translationsData.map((json) => Translation.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected format for translations: ${translationsData.runtimeType}');
      }
    } else {
      throw Exception('Error fetching translations: ${response.statusCode} ${response.body}');
    }
  }
}

/// Модель описания суры
class Surah {
  final int number;
  final String arabicName;
  final String name;
  final String englishName;
  final int versesCount;

  Surah({
    required this.number,
    required this.arabicName,
    required this.name,
    required this.englishName,
    required this.versesCount,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      number: json['id'] ?? 0,
      arabicName: json['name_arabic'] ?? '',
      name: json['name_simple'] ?? '',
      englishName: (json['translated_name'] != null && json['translated_name']['name'] != null)
          ? json['translated_name']['name']
          : '',
      versesCount: json['verses_count'] ?? 0,
    );
  }
}

/// Модель данных по джузу: номер джуза и список номеров сур
class JuzDetail {
  final int juzNumber;
  final List<int> surahNumbers;

  JuzDetail({
    required this.juzNumber,
    required this.surahNumbers,
  });
}

/// Модель описания аята (стиха)
class Verse {
  final int id;
  final int chapterId;
  final int verseNumber;
  final String verseKey;
  final String textUthmani;
  final String? translation;

  Verse({
    required this.id,
    required this.chapterId,
    required this.verseNumber,
    required this.verseKey,
    required this.textUthmani,
    this.translation,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    final dynamic rawId = json["id"];
    final int id = rawId is int ? rawId : 0;
    final dynamic rawChapterId = json["chapter_id"];
    final int chapterId = rawChapterId is int ? rawChapterId : 0;
    final dynamic rawVerseNumber = json["verse_number"];
    final int verseNumber = rawVerseNumber is int ? rawVerseNumber : 0;
    final String verseKey = json["verse_key"] ?? '';
    final String textUthmani = json["text_uthmani"] ?? '';

    String? trans;
    if (json.containsKey("translations") &&
        json["translations"] is List &&
        (json["translations"] as List).isNotEmpty) {
      trans = json["translations"][0]["text"] ?? '';
      if (trans!.isEmpty) {
        trans = null;
      }
    }
    return Verse(
      id: id,
      chapterId: chapterId,
      verseNumber: verseNumber,
      verseKey: verseKey,
      textUthmani: textUthmani,
      translation: trans,
    );
  }
}

/// Модель описания перевода Корана
class Translation {
  final int id;
  final String name;
  final String authorName;
  final String slug;
  final String languageName;
  final String translatedName;

  Translation({
    required this.id,
    required this.name,
    required this.authorName,
    required this.slug,
    required this.languageName,
    required this.translatedName,
  });

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      authorName: json['author_name'] ?? '',
      slug: json['slug'] ?? '',
      languageName: json['language_name'] ?? '',
      translatedName: (json['translated_name'] != null && json['translated_name']['name'] != null)
          ? json['translated_name']['name']
          : '',
    );
  }
}

// /// Преобразование числа в арабские цифры (0-9)
// String toArabicNumeral(int number) {
//   const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
//   return number.toString().split('').map((d) => arabicDigits[int.parse(d)]).join('');
// }
