import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LastReadSurah with ChangeNotifier {
  String _surahName = '';
  int _surahNumber = 1;

  String get surahName => _surahName;
  int get surahNumber => _surahNumber;

  LastReadSurah() {
    loadLastRead();
  }

  void saveLastRead() async {
    final box = await Hive.openBox('lastReadSurah');
    box.put('name', _surahName);
    box.put('number', _surahNumber);
    notifyListeners();
  }

  void loadLastRead() async {
    final box = await Hive.openBox('lastReadSurah');
    _surahName = box.get('name', defaultValue: '');
    _surahNumber = box.get('number', defaultValue: 1);
    notifyListeners();
  }

  void setLastReadSurah(String surahName) async {
    _surahName = surahName;
    saveLastRead();
  }

  void setLastReadSurahNumber(int surahNumber) async {
    _surahNumber = surahNumber;
    saveLastRead();
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
