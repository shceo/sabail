import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabail/domain/api/api.dart';
import 'package:sabail/provider/time_provider.dart';
import 'package:sabail/ui/theme/app_colors.dart';
import 'package:intl/intl.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabailColors.notwhite,
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
    super.key,
    required this.hijriDate,
    required this.monthNumber,
  }) : 
      monthName = HijriApi().getHijriMonthName(monthNumber);

  @override
  Widget build(BuildContext context) {
    final myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: myWidth * 0.1, 
              color: Colors.blue, 
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column(
                children: [
                  Text(
                    hijriDate,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Consumer<TimeProvider>(
                    builder: (context, timeProvider, child) {
                      final timeParts = timeProvider.currentTime.split(':');
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${timeParts[0]}:${timeParts[1]}',
                            style: const TextStyle(fontSize: 65),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            timeParts[2],
                            style: const TextStyle(fontSize: 30),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) => const CircleAvatar()),
            ),
          ],
        ),
      ),
    );
  }    
}

