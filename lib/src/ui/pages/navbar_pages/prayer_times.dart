import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sabail/src/domain/api/api.dart';
import 'package:sabail/src/provider/prayerpage_provider.dart';
import 'package:sabail/src/provider/user_city.dart';
import 'package:sabail/src/ui/theme/app_colors.dart';

class PrayTimes extends StatefulWidget {
  const PrayTimes({Key? key}) : super(key: key);

  @override
  _PrayTimesState createState() => _PrayTimesState();
}

class _PrayTimesState extends State<PrayTimes> {
  Future<void> _refreshData() async {
    // Если необходимо добавить логику обновления данных, добавьте её сюда.
    // Сейчас вызываем setState(), чтобы пересоздать FutureBuilder'ы.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final prayerTimesApi = PrayerTimes();
    final selectedCity = Provider.of<CityProvider>(context).selectedCity;

    return Scaffold(
      backgroundColor: SabailColors.notwhite,
      appBar: AppBar(
        title: Consumer<HijriDateModel>(
          builder: (context, model, child) {
            final now = DateTime.now();
            final dayOfWeek = getDayOfWeek(now.weekday);
            final formattedDate = '${now.day} ${getMonthName(now.month)}';
            return Text(
              '$dayOfWeek, $formattedDate',
              style: TextStyle(
                fontFamily: GoogleFonts.oswald().fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: SabailColors.notwhite,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        // Всегда можно прокрутить, даже если содержимого мало
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // --- Блок времени молитв для выбранного города ---
              FutureBuilder<String>(
                future: prayerTimesApi.getPrayerTime(selectedCity, today, 2),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Ошибка загрузки времени молитв');
                  } else {
                    final timings = snapshot.data!.split(',');
                    Map<String, String> prayerMap = {};
                    for (var item in timings) {
                      final parts = item.split(':');
                      if (parts.length >= 2) {
                        final prayerName = parts[0].trim();
                        final prayerTime = parts.sublist(1).join(':').trim();
                        prayerMap[prayerName] = prayerTime;
                      }
                    }
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: prayerMap.entries.map((entry) {
                          IconData icon;
                          switch (entry.key) {
                            case 'Fajr':
                              icon = Icons.nights_stay;
                              break;
                            case 'Dhuhr':
                              icon = Icons.wb_sunny;
                              break;
                            case 'Asr':
                              icon = Icons.cloud;
                              break;
                            case 'Maghrib':
                              icon = Icons.nightlight_round;
                              break;
                            case 'Isha':
                              icon = Icons.nightlight_round;
                              break;
                            default:
                              icon = Icons.access_time;
                          }
                          return _PrayerRow(
                            iconData: icon,
                            prayerName: entry.key,
                            prayerTime: entry.value,
                            bellIcon: Icons.notifications_active,
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              // --- Блок солнечной диаграммы (восход/закат) ---
              FutureBuilder<Map<String, String>>(
                future: prayerTimesApi.getSunTimes(selectedCity, today, 1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Text('Ошибка загрузки восхода и заката');
                  } else {
                    final sunTimes = snapshot.data!;
                    final sunrise = _parseTime(sunTimes['sunrise']!);
                    final sunset = _parseTime(sunTimes['sunset']!);
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          _SunPathDiagram(
                            sunrise: sunrise,
                            sunset: sunset,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.wb_sunny,
                                      color: Colors.orange),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${sunTimes['sunrise']}\nВосход',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${sunTimes['sunset']}\nЗакат',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge,
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.nightlight_round,
                                      color: Colors.blueGrey),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime _parseTime(String timeStr) {
    final now = DateTime.now();
    final parts = timeStr.split(':');
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}

class _PrayerRow extends StatelessWidget {
  final IconData iconData;
  final String prayerName;
  final String prayerTime;
  final IconData bellIcon;

  const _PrayerRow({
    Key? key,
    required this.iconData,
    required this.prayerName,
    required this.prayerTime,
    required this.bellIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(iconData,
              color: Theme.of(context).colorScheme.primary, size: 28),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              prayerName,
              style: textStyle?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Text(prayerTime, style: textStyle),
          const SizedBox(width: 10),
          Icon(bellIcon,
              size: 20, color: Theme.of(context).colorScheme.primary),
        ],
      ),
    );
  }
}

class _SunPathDiagram extends StatelessWidget {
  final DateTime sunrise;
  final DateTime sunset;

  const _SunPathDiagram({
    Key? key,
    required this.sunrise,
    required this.sunset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 150,
      child: CustomPaint(
        painter: _SunPathPainter(sunrise: sunrise, sunset: sunset),
      ),
    );
  }
}

class _SunPathPainter extends CustomPainter {
  final DateTime sunrise;
  final DateTime sunset;

  _SunPathPainter({
    required this.sunrise,
    required this.sunset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    final arcPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final arcRect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(arcRect, math.pi, math.pi, false, arcPaint);

    final now = DateTime.now();
    final totalDaylight = sunset.difference(sunrise).inMinutes;
    double progress = 0.0;
    if (totalDaylight > 0) {
      final passed = now.difference(sunrise).inMinutes;
      progress = passed / totalDaylight;
      if (progress < 0) progress = 0;
      if (progress > 1) progress = 1;
    }
    final currentAngle = math.pi - (math.pi * progress);
    final sunX = center.dx + radius * math.cos(currentAngle);
    final sunY = center.dy + radius * math.sin(currentAngle);

    final sunPaint = Paint()..color = Colors.yellow;
    canvas.drawCircle(Offset(sunX, sunY), 10, sunPaint);

    final moonX = center.dx + radius * math.cos(0);
    final moonY = center.dy + radius * math.sin(0);
    final moonPaint = Paint()..color = Colors.blueGrey;
    canvas.drawCircle(Offset(moonX, moonY), 8, moonPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

String getDayOfWeek(int weekday) {
  const days = [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье',
  ];
  return days[weekday - 1];
}

String getMonthName(int month) {
  const months = [
    'Января',
    'Февраля',
    'Марта',
    'Апреля',
    'Мая',
    'Июня',
    'Июля',
    'Августа',
    'Сентября',
    'Октября',
    'Ноября',
    'Декабря',
  ];
  return months[month - 1];
}
