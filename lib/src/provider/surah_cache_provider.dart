import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as Quran;

class Surah {
  final int number;
  final String name;
  final String englishName;
  final String arabicName;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.arabicName,
  });
}

class SurahCacheProvider extends ChangeNotifier {
  final List<Surah> _surahs = [];

  List<Surah> get surahs => _surahs;

  Future<void> loadSurahs() async {
    for (int i = 1; i <= Quran.totalSurahCount; i++) {
      _surahs.add(Surah(
        number: i,
        name: Quran.getSurahName(i),
        englishName: Quran.getSurahNameEnglish(i),
        arabicName: Quran.getSurahNameArabic(i),
      ));
    }
    notifyListeners();
  }
}
