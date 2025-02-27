import 'package:flutter/material.dart';
import 'package:sabail/src/domain/sql/last_read_dao.dart';

class LastReadSurah with ChangeNotifier {
  final LastReadDao _dao = LastReadDao();

  String _surahName = '';
  int _surahNumber = 1;
  int _verseNumber = 1;  // добавляем сохранение номера аята

  String get surahName => _surahName;
  int get surahNumber => _surahNumber;
  int get verseNumber => _verseNumber;

  LastReadSurah() {
    loadLastRead();
  }

  Future<void> saveLastRead() async {
    await _dao.saveLastRead(_surahNumber, _verseNumber);
  }

  Future<void> loadLastRead() async {
    final lastRead = await _dao.getLastRead();
    if (lastRead != null) {
      _surahNumber = lastRead['surah_number'] ?? 1;
      _verseNumber = lastRead['verse_number'] ?? 1;
      _surahName = lastRead['surah_name'] ?? '';  // имя теперь придется сохранять отдельно
    } else {
      _surahNumber = 1;
      _verseNumber = 1;
      _surahName = '';
    }
    notifyListeners();
  }

  void setLastReadSurah(String surahName) {
    _surahName = surahName;
    notifyListeners();
  }

  void setLastReadSurahNumber(int surahNumber) {
    _surahNumber = surahNumber;
    notifyListeners();
  }

  void setLastReadVerse(int verseNumber) {
    _verseNumber = verseNumber;
    saveLastRead();  // при установке сразу сохраняем в БД
    notifyListeners();
  }
}



class LastReadSurahProvider extends InheritedNotifier<LastReadSurah> {
  final LastReadSurah lastReadSurah;

  const LastReadSurahProvider({
    super.key,
    required this.lastReadSurah,
    required super.child,
  }) : super(notifier: lastReadSurah);

  static LastReadSurahProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LastReadSurahProvider>();
  }

  static LastReadSurahProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<LastReadSurahProvider>()?.widget;
    return widget is LastReadSurahProvider ? widget : null;
  }
}
