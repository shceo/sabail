import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabail/provider/prayerpage_provider.dart';
import 'package:sabail/ui/theme/app_colors.dart';

class PrayTimes extends StatelessWidget {
  const PrayTimes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<HijriDateModel>(context, listen: false).fetchHijriDate();
    final myWidth = MediaQuery.of(context).size.width;
    final myHeight = MediaQuery.of(context).size.height;
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
          const SizedBox(height: 15),
          const HijriDateText(),
          const SizedBox(height: 20),
          const AnimatedPrayerTimeGraph(),
          const SizedBox(height: 20),
          Container(
            width: myWidth / 1.14,
            height: myHeight / 2.1,
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.5),
              borderRadius: BorderRadius.circular(25)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _PrayerRow(iconData: Icons.access_time, prayerName: 'Fajr', bellIcon: Icons.notifications_active),
                Divider(),
                _PrayerRow(iconData: Icons.wb_sunny, prayerName: 'Sun Rise', bellIcon: Icons.notifications_active),
                Divider(),
                _PrayerRow(iconData: Icons.brightness_5, prayerName: 'Zuhr', bellIcon: Icons.notifications_active),
                Divider(),
                _PrayerRow(iconData: Icons.brightness_6, prayerName: 'Asr', bellIcon: Icons.notifications_active),
                Divider(),
                _PrayerRow(iconData: Icons.brightness_7, prayerName: 'Magrib', bellIcon: Icons.notifications_active),
                Divider(),
                _PrayerRow(iconData: Icons.star, prayerName: 'Isaa', bellIcon: Icons.notifications_active),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrayerRow extends StatelessWidget {
  final IconData iconData;
  final String prayerName;
  final IconData bellIcon;

  const _PrayerRow({
    Key? key,
    required this.iconData,
    required this.prayerName,
    required this.bellIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(iconData, color: Colors.yellow[700]),
        SizedBox(width: 10),
        Text(prayerName, style: TextStyle(fontSize: 18)),
        SizedBox(width: 5), // Adjust spacing between text and bell icon
        Padding(
          padding: EdgeInsets.only(left: 190),
          child: Icon(bellIcon, size: 16)), // Adding bell icon
      ],
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

class AnimatedPrayerTimeGraph extends StatelessWidget {
  const AnimatedPrayerTimeGraph({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    final myWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: myWidth / 2.5,
          height: 170,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(25)
          ),
          child: Column(
            children: [Text('Current Prayer')],
          ),
        ),
        SizedBox(width: 30),
        Container(
          width: myWidth / 2.5,
          height: 170,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(25)
          ),
          child: Column(
            children: [Text('Next Prayer')],
          ),
        ),
      ],
    );
  }
}
