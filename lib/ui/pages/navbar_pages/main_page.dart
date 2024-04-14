import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sabail/components/mainWidgets/mainpage_widgets.dart';
import 'package:sabail/components/prayerTimes/prayertimes_widget.dart';
import 'package:sabail/components/time/mainpage_time.dart';
import 'package:sabail/domain/api/api.dart';
import 'package:sabail/provider/time_provider.dart';
import 'package:sabail/provider/user_city.dart';
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
            return Consumer<CityProvider>(
              builder: (context, cityProvider, child) {
                return BodySab(
                  hijriDate: hijriDate,
                  monthNumber: monthNumber,
                  selectedCity: cityProvider.selectedCity,
                );
              },
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
    required String selectedCity,
  }) : monthName = HijriApi().getHijriMonthName(monthNumber);

  @override
  Widget build(BuildContext context) {
    return Consumer<CityProvider>(builder: (context, cityProvider, child) {
      return FutureBuilder<String>(
        future: PrayerTimes()
            .getPrayerTime(cityProvider.selectedCity, DateTime.now(), 2),
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
                  'assets/images/msq.png',
                  fit: BoxFit.fill,
                  width: 407, // 400
                  height: 259,
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
                                  onPressed: () async {
                                    final selectedCity =
                                        await Navigator.push<String>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CitiesAndCountriesPage(),
                                      ),
                                    );
                                    if (selectedCity != null) {
                                      Provider.of<CityProvider>(context,
                                              listen: true)
                                          .updateSelectedCity(selectedCity);
                                    }
                                  },
                                  child: Consumer<CityProvider>(
                                    builder: (context, cityProvider, child) {
                                      final defaultCity =
                                          cityProvider.selectedCity;

                                      return Text(
                                        defaultCity,
                                        style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.oswald().fontFamily,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 18),
                                      );
                                    },
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
                                    fontSize: 20,
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
                        child: SingleChildScrollView(
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
                              const MainWidgets(),
                              const SizedBox(height: 20),
                              const MainWidgets(),
                              const SizedBox(height: 20),
                              const MainWidgets(),
                            ],
                          ),
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
    });
  }
}
