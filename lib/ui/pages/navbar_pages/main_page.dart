import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; 
import 'package:provider/provider.dart';
import 'package:sabail/domain/api/api.dart';
import 'package:sabail/provider/time_provider.dart';
import 'package:sabail/ui/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabailColors.notwhite,
      body: StreamBuilder<String>(
        stream: HijriApi().getCurrentHijriDateStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitCircle(color: SabailColors.lightpurple),
                  const SizedBox(height: 20),
                  const Text('Загружаюсь...'),
                ],
              ),
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
  })  : monthName = HijriApi().getHijriMonthName(monthNumber);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0),
            ),
            child: Container(
              color: SabailColors.lightpurple.withOpacity(0.7),
              child: Column(
                children: [
                  const SizedBox(height: 60,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        hijriDate,
                        style: GoogleFonts.oswald(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
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
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 5,
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Фаджр', style: GoogleFonts.oswald()),
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/fajr.jpg'),
                      ),
                      Text('Первый', style: GoogleFonts.oswald()),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Зухр', style: GoogleFonts.oswald()),
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/sunrise.jpg'),
                      ),
                      Text('Второй', style: GoogleFonts.oswald()),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Аср', style: GoogleFonts.oswald()),
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/asr.jpg'),
                      ),
                      Text('Третий', style: GoogleFonts.oswald()),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Магриб', style: GoogleFonts.oswald()),
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/magrib.jpg'),
                      ),
                      Text('Четвертый', style: GoogleFonts.oswald()),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Иша', style: GoogleFonts.oswald()),
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/images/isha.jpg'),
                      ),
                      Text('Пятый', style: GoogleFonts.oswald()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
