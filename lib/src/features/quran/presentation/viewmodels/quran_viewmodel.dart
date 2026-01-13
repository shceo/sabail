import 'package:flutter/material.dart';

class QuranViewModel extends ChangeNotifier {
  bool ready = false;

  String get status => ready
      ? 'Готово к загрузке'
      : 'Подключение к API скоро будет доступно';

  void markReady() {
    ready = true;
    notifyListeners();
  }
}
