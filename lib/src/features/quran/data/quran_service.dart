import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/quran_models.dart';

class QuranService {
  static const String _baseUrl = 'https://api.alquran.cloud/v1';

  /// Fetch list of all 114 surahs
  Future<List<SurahInfo>> fetchSurahs() async {
    final response = await http.get(Uri.parse('$_baseUrl/surah'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> list = data['data'];
      return list.map((e) => SurahInfo.fromJson(e)).toList();
    }
    throw Exception('Failed to load surahs: ${response.statusCode}');
  }

  /// Fetch a single surah with Arabic text (Uthmani script)
  Future<List<Ayah>> fetchSurahArabic(int surahNumber) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/surah/$surahNumber/quran-uthmani'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> ayahs = data['data']['ayahs'];
      return ayahs.map((e) => Ayah.fromJson(e)).toList();
    }
    throw Exception('Failed to load surah: ${response.statusCode}');
  }

  /// Fetch a single surah with Russian translation
  Future<List<Ayah>> fetchSurahTranslation(int surahNumber,
      {String edition = 'ru.kuliev'}) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/surah/$surahNumber/$edition'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> ayahs = data['data']['ayahs'];
      return ayahs.map((e) => Ayah.fromJson(e)).toList();
    }
    throw Exception('Failed to load translation: ${response.statusCode}');
  }

  /// Fetch juz ayahs in Arabic
  Future<List<Ayah>> fetchJuzArabic(int juzNumber) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/juz/$juzNumber/quran-uthmani'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> ayahs = data['data']['ayahs'];
      return ayahs.map((e) => Ayah.fromJson(e)).toList();
    }
    throw Exception('Failed to load juz: ${response.statusCode}');
  }

  /// Fetch a single Quran page (1-604) with Arabic text
  Future<List<Ayah>> fetchPage(int pageNumber) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/page/$pageNumber/quran-uthmani'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> ayahs = data['data']['ayahs'];
      return ayahs.map((e) => Ayah.fromJson(e)).toList();
    }
    throw Exception('Failed to load page: ${response.statusCode}');
  }
}
