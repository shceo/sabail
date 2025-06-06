// lib/src/presentation/features/prayer_times/view/prayer_times_page.dart

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabail/src/presentation/features/prayer_times/cubit/prayer_cubit.dart';

import '../../../app/app_colors.dart';

/// Экран "Время молитв" в стиле MVVM
class PrayerTimesPage extends StatelessWidget {
  const PrayerTimesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<PrayerCubit>();
    final vm = cubit.state;
    final now = DateTime.now();
    final dayOfWeek = _getDayOfWeek(now.weekday);
    final dateLabel = '${now.day} ${_getMonthName(now.month)}';

    return Scaffold(
      backgroundColor: SabailColors.notwhite,
      appBar: AppBar(
        backgroundColor: SabailColors.notwhite,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '$dayOfWeek, $dateLabel',
          style: TextStyle(
            fontFamily: GoogleFonts.oswald().fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: vm.isLoading
          ? Center(child: SpinKitCircle(color: SabailColors.lightpurple))
          : vm.errorMessage != null
          ? Center(child: Text(vm.errorMessage!))
          : RefreshIndicator(
              onRefresh: vm.loadAllData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _PrayerTimesSection(vm: vm),
                    const SizedBox(height: 20),
                    _SunDiagramSection(
                      sunrise: vm.sunrise!,
                      sunset: vm.sunset!,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _PrayerTimesSection extends StatelessWidget {
  final PrayerState vm;
  const _PrayerTimesSection({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: vm.prayerTimes.map((entry) {
          final parts = entry.split(': ');
          final name = parts[0];
          final time = parts.length > 1 ? parts[1] : '--:--';
          IconData icon;
          switch (name) {
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
            prayerName: name,
            prayerTime: time,
            bellIcon: Icons.notifications_active,
          );
        }).toList(),
      ),
    );
  }
}

class _SunDiagramSection extends StatelessWidget {
  final DateTime sunrise;
  final DateTime sunset;
  const _SunDiagramSection({
    Key? key,
    required this.sunrise,
    required this.sunset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _SunPathDiagram(sunrise: sunrise, sunset: sunset),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.wb_sunny, color: Colors.orange),
                  const SizedBox(width: 4),
                  Text(
                    '${_formatTime(sunrise)}\nВосход',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${_formatTime(sunset)}\nЗакат',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.nightlight_round, color: Colors.blueGrey),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
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
          Icon(
            iconData,
            color: Theme.of(context).colorScheme.primary,
            size: 28,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              prayerName,
              style: textStyle?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Text(prayerTime, style: textStyle),
          const SizedBox(width: 10),
          Icon(
            bellIcon,
            size: 20,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

class _SunPathDiagram extends StatelessWidget {
  final DateTime sunrise;
  final DateTime sunset;

  const _SunPathDiagram({Key? key, required this.sunrise, required this.sunset})
    : super(key: key);

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

  _SunPathPainter({required this.sunrise, required this.sunset});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;
    final passedPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final remainingPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final totalAngle = math.pi;
    final totalDay = sunset.difference(sunrise).inMinutes.toDouble();
    final now = DateTime.now();
    final passedDay = now.difference(sunrise).inMinutes.toDouble();
    final progress = totalDay > 0 ? (passedDay / totalDay).clamp(0, 1) : 0;
    final passedSweep = totalAngle * progress;
    canvas.drawArc(rect, math.pi, passedSweep, false, passedPaint);
    const dashLen = 10.0, gapLen = 5.0;
    final dashAng = dashLen / radius;
    final gapAng = gapLen / radius;
    double startAng = math.pi + passedSweep;
    final endAng = math.pi + totalAngle;
    while (startAng < endAng) {
      final nextAng = (startAng + dashAng).clamp(startAng, endAng);
      canvas.drawArc(rect, startAng, nextAng - startAng, false, remainingPaint);
      startAng = nextAng + gapAng;
    }
    final sunAng = math.pi + passedSweep;
    final sunPos = Offset(
      center.dx + radius * math.cos(sunAng),
      center.dy + radius * math.sin(sunAng),
    );
    canvas.drawCircle(sunPos, 10, Paint()..color = Colors.yellow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

String _getDayOfWeek(int wd) {
  const days = [
    'Понедельник',
    'Вторник',
    'Среда',
    'Четверг',
    'Пятница',
    'Суббота',
    'Воскресенье',
  ];
  return days[wd - 1];
}

String _getMonthName(int m) {
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
  return months[m - 1];
}
