import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sabail/components/mainWidgets/mainpage_widgets.dart';
import 'package:sabail/components/prayerTimes/prayertimes_widget.dart';
import 'package:sabail/components/time/mainpage_time.dart';
import 'package:sabail/domain/api/api.dart';
import 'package:sabail/provider/time_provider.dart';
import 'package:sabail/ui/pages/countries_page.dart';
import 'package:sabail/ui/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key});

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
    Key? key,
    required this.hijriDate,
    required this.monthNumber,
  }) : monthName = HijriApi().getHijriMonthName(monthNumber);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: PrayerTimes().getPrayerTime('Ташкент', DateTime.now(), 2),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        final prayerTimes = snapshot.data != null
            ? snapshot.data!.split(', ')
            : [
                'Fajr: --:--',
                'Dhuhr: --:--',
                'Asr: --:--',
                'Maghrib: --:--',
                'Isha: --:--'
              ];
        final fajrTime = prayerTimes[0].split(': ')[1];
        final dhuhrTime = prayerTimes[1].split(': ')[1];
        final asrTime = prayerTimes[2].split(': ')[1];
        final maghribTime = prayerTimes[3].split(': ')[1];
        final ishaTime = prayerTimes[4].split(': ')[1];

        return Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/msqshil.png',
                fit: BoxFit.fill,
                width: 300,
                height: 287,
              ),
            ),
            Column(
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
                          const SizedBox(
                            height: 60,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CitiesAndCountriesPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Текущее место',
                                  style: TextStyle(
                                    fontFamily: GoogleFonts.oswald().fontFamily,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text(
                                hijriDate,
                                style: TextStyle(
                                  fontFamily: GoogleFonts.oswald().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Consumer<TimeProvider>(
                            builder: (context, timeProvider, child) {
                              return CurrentTimeWidget(
                                  time: timeProvider.currentTime);
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
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          PrayTimesWidget(
                            fajrTime: fajrTime,
                            dhuhrTime: dhuhrTime,
                            asrTime: asrTime,
                            maghribTime: maghribTime,
                            ishaTime: ishaTime,
                          ),
                          const SizedBox(height: 30),
                          EmptyBlocksRow(),
                          const SizedBox(height: 20),
                          EmptyBlocksRow(),
                          const SizedBox(height: 20),
                          EmptyBlocksRow(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
