import 'package:flutter/material.dart';
class LastReadSurah with ChangeNotifier {
  String _surahName = '';
  int _ayahNumber = 0; // Add this line

  String get surahName => _surahName;
  int get ayahNumber => _ayahNumber; // Add this line

  void setLastReadSurah(String surahName) {
    _surahName = surahName;
    notifyListeners();
  }

  void setLastReadAyah(int ayahNumber) { // Add this method
    _ayahNumber = ayahNumber;
    notifyListeners();
  }
}




class LastReadSurahProvider extends InheritedNotifier {
  final LastReadSurah lastReadSurah;

  LastReadSurahProvider({
    Key? key,
    required LastReadSurah lastReadSurah,
    required Widget child,
  })  : assert(lastReadSurah != null),
        this.lastReadSurah = lastReadSurah,
        super(key: key, notifier: lastReadSurah, child: child);

  static LastReadSurahProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LastReadSurahProvider>();
  }

  static LastReadSurahProvider? read(BuildContext context) {
    final widget = context.getElementForInheritedWidgetOfExactType<LastReadSurahProvider>()?.widget;
    return widget is LastReadSurahProvider ? widget : null;
  }
}

