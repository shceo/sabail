import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sabail/domain/api/api.dart';
import 'package:sabail/provider/time_provider.dart';
import 'package:sabail/ui/pages/countries_page.dart';
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
  }) : monthName = HijriApi().getHijriMonthName(monthNumber);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: PrayerTimes().getPrayerTime('Tashkent', DateTime.now(), 2),
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
                                  builder: (context) => CitiesAndCountriesPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Текущее место',
                              style: TextStyle(
                                fontFamily: GoogleFonts.oswald().fontFamily,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
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
                            style:
                                GoogleFonts.oswald(fontWeight: FontWeight.bold),
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
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text('Фаджр', style: GoogleFonts.oswald()),
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/fajr.jpg'),
                              ),
                              Text(fajrTime, style: GoogleFonts.oswald()),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Зухр', style: GoogleFonts.oswald()),
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/sunrise.jpg'),
                              ),
                              Text(dhuhrTime, style: GoogleFonts.oswald()),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Аср', style: GoogleFonts.oswald()),
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/asr.jpg'),
                              ),
                              Text(asrTime, style: GoogleFonts.oswald()),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Магриб', style: GoogleFonts.oswald()),
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/magrib.jpg'),
                              ),
                              Text(maghribTime, style: GoogleFonts.oswald()),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Иша', style: GoogleFonts.oswald()),
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/isha.jpg'),
                              ),
                              Text(ishaTime, style: GoogleFonts.oswald()),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            3,
                            (index) => Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[300],
                                  ),
                                )),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            3,
                            (index) => Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[300],
                                  ),
                                )),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            3,
                            (index) => Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[300],
                                  ),
                                )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}