import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrayTimesWidget extends StatelessWidget {
  final String fajrTime;
  final String dhuhrTime;
  final String asrTime;
  final String maghribTime;
  final String ishaTime;

  const PrayTimesWidget({
    super.key,
    required this.fajrTime,
    required this.dhuhrTime,
    required this.asrTime,
    required this.maghribTime,
    required this.ishaTime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text('Фаджр', style: GoogleFonts.oswald()),
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/fajr.jpg'),
            ),
            Text(fajrTime, style: GoogleFonts.oswald()),
          ],
        ),
        Column(
          children: [
            Text('Зухр', style: GoogleFonts.oswald()),
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/sunrise.jpg'),
            ),
            Text(dhuhrTime, style: GoogleFonts.oswald()),
          ],
        ),
        Column(
          children: [
            Text('Аср', style: GoogleFonts.oswald()),
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/asr.jpg'),
            ),
            Text(asrTime, style: GoogleFonts.oswald()),
          ],
        ),
        Column(
          children: [
            Text('Магриб', style: GoogleFonts.oswald()),
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/magrib.jpg'),
            ),
            Text(maghribTime, style: GoogleFonts.oswald()),
          ],
        ),
        Column(
          children: [
            Text('Иша', style: GoogleFonts.oswald()),
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/isha.jpg'),
            ),
            Text(ishaTime, style: GoogleFonts.oswald()),
          ],
        ),
      ],
    );
  }
}
