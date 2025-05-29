// lib/src/presentation/features/home/view/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabail/src/presentation/app/app_colors.dart';
import 'package:sabail/src/presentation/features/home/view_model/home_vm.dart' show HomeViewModel;
import 'package:sabail/src/ui/pages/countries_page.dart';

import '../view/widgets/mainpage_widgets.dart';
import '../view/widgets/mainpod_widgets.dart';
import '../view/widgets/mainthree_widget.dart';
import '../view/widgets/mainpage_time.dart';
import '../../prayer_times/view/widgets/prayertimes_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    // пока не загрузилась hijriDate
    if (vm.hijriDate.isEmpty) {
      return Scaffold(
        backgroundColor: SabailColors.notwhite,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitCircle(color: SabailColors.lightpurple),
              const SizedBox(height: 20),
              const Text('Загружаюсь...'),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: SabailColors.notwhite,
      body: const BodySab(),
    );
  }
}

class BodySab extends StatelessWidget {
  const BodySab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();
    final cityLabel = vm.selectedCity.isEmpty ? 'Выберите город' : vm.selectedCity;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Верхний блок
        Expanded(
          flex: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              color: SabailColors.lightpurple.withOpacity(0.7),
              child: LayoutBuilder(builder: (ctx, bc) {
                final w = bc.maxWidth;
                final h = bc.maxHeight;
                return Stack(
                  children: [
                    // фоновые иконки...
                    Padding(
                      padding: EdgeInsets.only(
                        left: w * 0.05,
                        top: h * 0.15,
                        right: w * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () async {
                              final selected = await Navigator.push<String>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CitiesAndCountriesPage(),
                                ),
                              );
                              if (selected != null) {
                                await vm.selectCity(selected);
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: w * 0.05,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  cityLabel,
                                  style: TextStyle(
                                    fontSize: w * 0.045,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: GoogleFonts.oswald().fontFamily,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            vm.hijriDate,
                            style: TextStyle(
                              fontSize: w * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: GoogleFonts.oswald().fontFamily,
                            ),
                          ),
                          SizedBox(height: h * 0.08),
                          CurrentTimeWidget(time: vm.currentTime),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),

        // Нижний блок
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                PrayTimesWidget(
                  fajrTime: vm.prayerTimes[0].split(': ')[1],
                  dhuhrTime: vm.prayerTimes[1].split(': ')[1],
                  asrTime: vm.prayerTimes[2].split(': ')[1],
                  maghribTime: vm.prayerTimes[3].split(': ')[1],
                  ishaTime: vm.prayerTimes[4].split(': ')[1],
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
      ],
    );
  }
}
