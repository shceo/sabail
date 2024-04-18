import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabail/provider/prayerpage_provider.dart';
import 'package:sabail/ui/theme/app_colors.dart';

class PrayTimes extends StatelessWidget {
  const PrayTimes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<HijriDateModel>(context, listen: false).fetchHijriDate();

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
      body: Column(
        children: [
          const HijriDateText(),
          Expanded(
            child: CustomPaint(
              painter: PrayerTimeGraph(Provider.of<PrayerTimesModel>(context)),
              child: Container(),
            ),
          )
        ],
      ),
    );
  }
}

class HijriDateText extends StatelessWidget {
  const HijriDateText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Consumer<HijriDateModel>(
        builder: (context, model, child) {
          return Text(
            model.hijriDate.isEmpty ? '--:--' : model.hijriDate,
            style: TextStyle(
              fontFamily: GoogleFonts.oswald().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.grey.withOpacity(0.7),
            ),
          );
        },
      ),
    );
  }
}

class PrayerTimesModel with ChangeNotifier {
  String fajr = '04:11';
  String sunrise = '06:00';
  String dhuhr = '12:33';
  String asr = '16:03';
  String sunset = '19:08';
  String maghrib = '19:08';
  String isha = '20:57';
  String imsak = '04:01';
  String midnight = '00:34';

  void updatePrayerTimes(Map<String, String> newTimes) {
    fajr = newTimes['Fajr'] ?? fajr;
    sunrise = newTimes['Sunrise'] ?? sunrise;
    dhuhr = newTimes['Dhuhr'] ?? dhuhr;
    asr = newTimes['Asr'] ?? asr;
    sunset = newTimes['Sunset'] ?? sunset;
    maghrib = newTimes['Maghrib'] ?? maghrib;
    isha = newTimes['Isha'] ?? isha;
    imsak = newTimes['Imsak'] ?? imsak;
    midnight = newTimes['Midnight'] ?? midnight;

    notifyListeners();
  }
}

class PrayerTimeGraph extends CustomPainter {
  final PrayerTimesModel prayerTimes;

  PrayerTimeGraph(this.prayerTimes);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width * 0.45;

    final Paint sunPaint = Paint()..color = Colors.orange;
    final Paint moonPaint = Paint()..color = Colors.grey[300]!;
    // final Paint textPaint = Paint()
      // ..color = Colors.black
      // ..textAlign = TextAlign.center;

    final Offset center = Offset(size.width / 2, size.height * 0.3); 

    // Draw sun
    final double sunX = center.dx - radius * math.sin(math.pi / 3);
    final double sunY = center.dy - radius * math.cos(math.pi / 3);
    canvas.drawCircle(Offset(sunX, sunY), 20, sunPaint);

    // Draw moon
    final double moonX = center.dx + radius * math.sin(math.pi / 3);
    final double moonY = center.dy - radius * math.cos(math.pi / 3);
    canvas.drawCircle(Offset(moonX, moonY), 20, moonPaint);

    // Draw graph
    final Paint graphPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3;

    final double graphStartX = center.dx - radius;
    final double graphEndX = center.dx + radius;
    final double graphY = center.dy;

    canvas.drawLine(
      Offset(graphStartX, graphY),
      Offset(graphEndX, graphY),
      graphPaint,
    );

    // Draw labels
    final textStyle = TextStyle(
      color: Colors.black,
      fontFamily: GoogleFonts.oswald().fontFamily,
      fontSize: 14,
    );

    final textSpanFajr = TextSpan(text: 'Fajr', style: textStyle);
    final textSpanDhuhr = TextSpan(text: 'Dhuhr', style: textStyle);
    final textSpanAsr = TextSpan(text: 'Asr', style: textStyle);
    final textSpanMaghrib = TextSpan(text: 'Maghrib', style: textStyle);
    final textSpanIsha = TextSpan(text: 'Isha', style: textStyle);

    final textPainterFajr = TextPainter(
      text: textSpanFajr,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: size.width);

    final textPainterDhuhr = TextPainter(
      text: textSpanDhuhr,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: size.width);

    final textPainterAsr = TextPainter(
      text: textSpanAsr,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: size.width);

    final textPainterMaghrib = TextPainter(
      text: textSpanMaghrib,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: size.width);

    final textPainterIsha = TextPainter(
      text: textSpanIsha,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: size.width);

    textPainterFajr.paint(canvas, Offset(graphStartX - 20, graphY - 20));
    textPainterDhuhr.paint(canvas, Offset(graphStartX + radius * 0.25, graphY - 20));
    textPainterAsr.paint(canvas, Offset(center.dx - 10, graphY - 20));
    textPainterMaghrib.paint(canvas, Offset(graphStartX + radius * 0.75, graphY - 20));
    textPainterIsha.paint(canvas, Offset(graphEndX - 20, graphY - 20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
