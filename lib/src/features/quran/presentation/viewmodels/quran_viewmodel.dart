import 'package:flutter/material.dart';
import 'package:sabail/src/features/quran/data/models/quran_models.dart';
import 'package:sabail/src/features/quran/data/quran_service.dart';

class QuranViewModel extends ChangeNotifier {
  final QuranService _service = QuranService();

  List<SurahInfo> surahs = [];
  bool isLoading = false;
  String? error;
  int selectedTab = 0; // 0=surahs, 1=juz, 2=bookmarks

  Future<void> loadSurahs() async {
    if (surahs.isNotEmpty) return;
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      surahs = await _service.fetchSurahs();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = _loadErrorMessage(e);
      notifyListeners();
    }
  }

  void setTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  String _loadErrorMessage(Object error) {
    final normalized = error.toString().toLowerCase();
    if (normalized.contains('failed host lookup') ||
        normalized.contains('socketexception') ||
        normalized.contains('clientexception') ||
        normalized.contains('connection closed') ||
        normalized.contains('timed out')) {
      return 'Проверь подключение к интернету и попробуй снова.';
    }
    return 'Не удалось загрузить данные.';
  }
}
