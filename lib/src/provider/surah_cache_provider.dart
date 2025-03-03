import 'package:flutter/material.dart';
import 'package:sabail/src/domain/api/quran_api.dart' show Surah, QuranApiService;

class SurahCacheProvider extends ChangeNotifier {
  List<Surah> _surahs = [];

  List<Surah> get surahs => _surahs;

  Future<void> loadSurahs() async {
    try {
      _surahs = await QuranApiService.fetchChapters();
      notifyListeners();
    } catch (e) {
      print("Ошибка загрузки сур: $e");
    }
  }
}
