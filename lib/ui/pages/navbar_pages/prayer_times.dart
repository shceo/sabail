import 'dart:async';
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
          const SizedBox(height: 20),
          const HijriDateText(),
          Expanded(
            child: AnimatedPrayerTimeGraph(
              provider: Provider.of<PrayerTimesModel>(context),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 200,
            height: 200,
            color: Colors.purple.withOpacity(0.5),
          ),
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

class AnimatedPrayerTimeGraph extends StatefulWidget {
  final PrayerTimesModel provider;

  const AnimatedPrayerTimeGraph({Key? key, required this.provider}) : super(key: key);

  @override
  _AnimatedPrayerTimeGraphState createState() => _AnimatedPrayerTimeGraphState();
}

class _AnimatedPrayerTimeGraphState extends State<AnimatedPrayerTimeGraph> {
  bool isSun = true; // Переменная для отслеживания состояния солнца

  @override
  void initState() {
    super.initState();
    // Анимация смены солнца на луну через 5 секунд после загрузки виджета
    Timer(Duration(seconds: 5), () {
      setState(() {
        isSun = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PrayerTimeGraph(widget.provider, isSun),
      child: Container(),
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
  final bool isSun;

  PrayerTimeGraph(this.prayerTimes, this.isSun);

@override
void paint(Canvas canvas, Size size) {
  final double radius = size.width * 0.45;

  final Paint sunPaint = Paint()..color = Colors.orange;
  final Paint moonPaint = Paint()..color = Colors.grey[300]!;
  final Paint linePaint = Paint()
    ..color = Colors.blue
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke;

  final Offset center = Offset(size.width / 2, size.height / 2);

  if (isSun) {
    final double sunX = center.dx;
    final double sunY = center.dy - radius;
    canvas.drawCircle(Offset(sunX, sunY), 20, sunPaint);
  } else {
    final double moonX = center.dx;
    final double moonY = center.dy - radius;
    canvas.drawCircle(Offset(moonX, moonY), 20, moonPaint);
  }

  final Rect rect = Rect.fromCircle(center: center, radius: radius);

  final double startAngle = -math.pi / 3;
  final double sweepAngle = math.pi;

  canvas.drawArc(rect, startAngle, sweepAngle, false, linePaint);

  // Draw labels
  final double graphStartX = center.dx - radius;
  final double graphEndX = center.dx + radius;
  final double graphY = center.dy;

  // Draw only one line instead of two
  final double lineY = center.dy - radius;
  canvas.drawLine(
    Offset(graphStartX, lineY),
    Offset(graphEndX, lineY),
    linePaint,
  );
}


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
