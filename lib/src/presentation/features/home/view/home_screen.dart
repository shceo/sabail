import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sabail/src/presentation/features/home/view/widgets/mainpage_widgets.dart';
import 'package:sabail/src/presentation/features/home/view/widgets/mainpod_widgets.dart';
import 'package:sabail/src/presentation/features/home/view/widgets/mainthree_widget.dart';
import 'package:sabail/src/presentation/features/prayer_times/view/widgets/prayertimes_widget.dart';
import 'package:sabail/src/presentation/features/home/view/widgets/mainpage_time.dart';
import 'package:sabail/src/domain/api/api.dart';
import 'package:sabail/src/provider/time_provider.dart';
import 'package:sabail/src/provider/user_city.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:sabail/src/ui/pages/countries_page.dart';
import 'package:sabail/src/presentation/app/app_colors.dart';

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
            // Учтите, что тут парсинг месяца может требовать доработки
            final monthNumber = int.tryParse(hijriDate.split('')[1]) ?? 1;
            // Здесь не создаём новый CityProvider – используем глобальный, который уже передан через main.dart
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

class BodySab extends StatefulWidget {
  final String hijriDate;
  final int monthNumber;

  const BodySab({
    super.key,
    required this.hijriDate,
    required this.monthNumber,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BodySabState createState() => _BodySabState();
}

class _BodySabState extends State<BodySab> {
  // late String _selectedCity;

  String? _selectedCity;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedCity = Provider.of<CityProvider>(context).selectedCity;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CityProvider>(
      builder: (context, cityProvider, child) {
        return FutureBuilder<String>(
          future:
              PrayerTimes().getPrayerTime(_selectedCity!, DateTime.now(), 2),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            final prayerTimes = snapshot.data != null
                ? snapshot.data!.split(', ')
                : [
                    'Fajr: --:--',
                    'Dhuhr: --:--',
                    'Asr: --:--',
                    'Maghrib: --:--',
                    'Isha: --:--',
                  ];
            final fajrTime = prayerTimes[0].split(': ')[1];
            final dhuhrTime = prayerTimes[1].split(': ')[1];
            final asrTime = prayerTimes[2].split(': ')[1];
            final maghribTime = prayerTimes[3].split(': ')[1];
            final ishaTime = prayerTimes[4].split(': ')[1];

            return Stack(
              children: [
                // Image.asset(
                //   'assets/images/msq1.png',
                //   // fit: BoxFit.fill,
                // // width: 406.9,
                // // height: 255.3,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Верхняя часть страницы с тематическим оформлением
                    Expanded(
                      flex: 0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0),
                        ),
                        child: Container(
                          width: double.infinity,
                          // Высоту можно задать как долю от общей высоты экрана, например:
                          height: MediaQuery.of(context).size.height * 0.35,
                          color: SabailColors.lightpurple.withOpacity(0.7),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final width = constraints.maxWidth;
                              final height = constraints.maxHeight;
                              return Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: height * 0.05,
                                        right: width * 0.05,
                                      ),
                                      child: Icon(
                                        FlutterIslamicIcons.mosque,
                                        color: Colors.white.withOpacity(0.2),
                                        size: width * 0.35,
                                      ),
                                    ),
                                  ),
                                  // Иконка полумесяца в левом верхнем углу
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: width * 0.05,
                                        bottom: height * 0.25,
                                      ),
                                      child: Icon(
                                        FlutterIslamicIcons.crescentMoon,
                                        color: Colors.white.withOpacity(0.3),
                                        size: width * 0.15,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const Alignment(-0.2, -0.8),
                                    child: Icon(
                                      Icons.star,
                                      size: width * 0.05,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                  Align(
                                    alignment: const Alignment(0.6, -0.6),
                                    child: Icon(
                                      Icons.star,
                                      size: width * 0.06,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                  Align(
                                    alignment: const Alignment(-0.7, -0.4),
                                    child: Icon(
                                      Icons.star,
                                      size: width * 0.04,
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                                  ),
                                  Align(
                                    alignment: const Alignment(0.2, -0.9),
                                    child: Icon(
                                      Icons.star,
                                      size: width * 0.045,
                                      color: Colors.white.withOpacity(0.65),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: width * 0.05,
                                      top: height * 0.15,
                                      right: width * 0.05,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            final selectedCity =
                                                await Navigator.push<String>(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const CitiesAndCountriesPage(),
                                              ),
                                            );
                                            if (selectedCity != null) {
                                              Provider.of<CityProvider>(context,
                                                      listen: false)
                                                  .updateSelectedCity(
                                                      selectedCity);
                                            }
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.white,
                                                size: width * 0.05,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                _selectedCity ??
                                                    'Выберите город',
                                                style: TextStyle(
                                                  fontFamily:
                                                      GoogleFonts.oswald()
                                                          .fontFamily,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: width * 0.045,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          widget.hijriDate,
                                          style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.oswald().fontFamily,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: width * 0.05,
                                          ),
                                        ),
                                        SizedBox(height: height * 0.08),
                                        Consumer<TimeProvider>(
                                          builder:
                                              (context, timeProvider, child) {
                                            return CurrentTimeWidget(
                                              time: timeProvider.currentTime,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
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
                                const SizedBox(height: 20),
                                const MainWidgets(),
                                const SizedBox(height: 20),
                                const MainPodWidgets(),
                                const SizedBox(height: 20),
                                const MainThreePodWidget(),
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
      },
    );
  }
}
