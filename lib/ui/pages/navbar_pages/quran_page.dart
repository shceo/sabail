import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as Quran;
import 'package:sabail/ui/theme/app_colors.dart';

class AlQuranPage extends StatelessWidget {
  const AlQuranPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabailColors.notwhite,
      appBar: AppBar(
        backgroundColor: SabailColors.notwhite,
        title: Text('Аль Коран'),
      ),
      body: BodyAl(),
    );
  }
}

class BodyAl extends StatelessWidget {
  const BodyAl({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Quran.totalSurahCount,
      itemBuilder: (context, index) {
        final surahNumber = index + 1;
        final surahName = Quran.getSurahName(surahNumber);
        final surahEnglishName = Quran.getSurahNameEnglish(surahNumber);
        return ListTile(
          title: Text(surahName),
          subtitle: Text(surahEnglishName),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurahScreen(surahNumber: surahNumber),
              ),
            );
          },
        );
      },
    );
  }
}

class SurahScreen extends StatelessWidget {
  final int surahNumber;

  const SurahScreen({Key? key, required this.surahNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final surahName = Quran.getSurahName(surahNumber);
   
    return Scaffold(
      appBar: AppBar(
        title: Text(surahName),
      ),
      body: Center(
        child: Text('Здесь будут аяты суры $surahName'),
      ),
    );
  }
}
