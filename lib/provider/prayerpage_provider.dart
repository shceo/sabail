import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sabail/domain/api/api.dart';

class HijriDateModel extends ChangeNotifier {
  String _hijriDate = '';

  String get hijriDate => _hijriDate;

  void fetchHijriDate() async {
    try {
      final hijriDate = await HijriApi().getCurrentHijriDate();
      _hijriDate = hijriDate;
      notifyListeners();
    } catch (error) {
      Fluttertoast.showToast(
          msg: "Что то пошло не так: $error",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.purple,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}




String getDayOfWeek(int day) {
  switch (day) {
    case 1:
      return 'Понедельник';
    case 2:
      return 'Вторник';
    case 3:
      return 'Среда';
    case 4:
      return 'Четверг';
    case 5:
      return 'Пятница';
    case 6:
      return 'Суббота';
    case 7:
      return 'Воскресенье';
    default:
      return '';
  }
}

// Функция для получения названия месяца
String getMonthName(int month) {
  switch (month) {
    case 1:
      return 'Января';
    case 2:
      return 'Февраля';
    case 3:
      return 'Марта';
    case 4:
      return 'Апреля';
    case 5:
      return 'Мая';
    case 6:
      return 'Июня';
    case 7:
      return 'Июля';
    case 8:
      return 'Августа';
    case 9:
      return 'Сентября';
    case 10:
      return 'Октября';
    case 11:
      return 'Ноября';
    case 12:
      return 'Декабря';
    default:
      return '';
  }
}
