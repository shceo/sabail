import 'package:flutter/material.dart';
import 'package:sabail/src/features/quran/data/models/quran_models.dart';
import 'package:sabail/src/features/quran/data/quran_service.dart';

class QuranViewModel extends ChangeNotifier {
  final QuranService _service = QuranService();

  List<SurahInfo> surahs = [];
  bool isLoading = false;
  String? error;
  int selectedTab = 0; // 0=Суры, 1=Джуз, 2=Закладки

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
      error = 'Не удалось загрузить данные';
      notifyListeners();
    }
  }

  void setTab(int index) {
    selectedTab = index;
    notifyListeners();
  }
}
