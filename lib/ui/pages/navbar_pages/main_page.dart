import 'package:flutter/material.dart';
import 'package:sabail/domain/api/api.dart'; // Импортируем класс для работы с API
import 'package:sabail/ui/theme/app_colors.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabailColors.notwhite,
      appBar: AppBar(
        backgroundColor: SabailColors.notwhite,
        centerTitle: true,
      ),
      body: FutureBuilder<String>(
        future: HijriApi().getCurrentHijriDate(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) { 
            return Center(
              child: Text('Ошибка при загрузке данных: ${snapshot.error}'),
            );
          } else {
            return BodySab(hijriDate: snapshot.data!); 
          }
        },
      ),
    );
  }
}

class BodySab extends StatelessWidget {
  final String hijriDate; 

  const BodySab({Key? key, required this.hijriDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            height: 100,
            width: 100,
            child: Text(hijriDate),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
            height: 100,
            width: 100,
          ),
        ),
      ],
    );
  }
}
