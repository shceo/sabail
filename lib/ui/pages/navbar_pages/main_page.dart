import 'package:flutter/material.dart';
import 'package:sabail/ui/theme/app_colors.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabailColors.notwhite,
      appBar: AppBar(
        backgroundColor: SabailColors.notwhite,
        centerTitle: true,
      ),
      body: const BodySab(),
    );
  }
}

class BodySab extends StatelessWidget {
  const BodySab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 50), // Отступ для второго контейнера
            decoration: BoxDecoration(
              color: Colors.blue, // Замените на нужный цвет
              borderRadius: BorderRadius.circular(15), // Закругленные углы
            ),
            height: 100, // Замените на нужную высоту
            width: 100, // Замените на нужную ширину
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red, // Замените на нужный цвет
              borderRadius: BorderRadius.circular(15), // Закругленные углы
            ),
            height: 100, // Замените на нужную высоту
            width: 100, // Замените на нужную ширину
          ),
        ),
      ],
    );
  }
}
