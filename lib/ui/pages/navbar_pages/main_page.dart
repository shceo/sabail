import 'package:flutter/material.dart';
import 'package:sabail/domain/api/api.dart';
import 'package:sabail/ui/theme/app_colors.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabailColors.notwhite,
      appBar: AppBar(
        backgroundColor: SabailColors.notwhite,
        centerTitle: true,
      ),
      body: StreamBuilder<String>(
        stream: HijriApi().getCurrentHijriDateStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Ошибка при загрузке данных: ${snapshot.error}'),
            );
          } else {
            final hijriDate = snapshot.data!;
            final monthNumber = int.parse(hijriDate.split('')[1]);
            return BodySab(
              hijriDate: hijriDate,
              monthNumber: monthNumber,
            );
          }
        },
      ),
    );
  }
}

class BodySab extends StatelessWidget {
  final String hijriDate;
  final int monthNumber;
  final String monthName;

   BodySab({
    Key? key,
    required this.hijriDate,
    required this.monthNumber,
  }) : 
      monthName = HijriApi().getHijriMonthName(monthNumber),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            height: 150,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$hijriDate',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
