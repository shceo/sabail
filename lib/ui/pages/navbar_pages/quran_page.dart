import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as Quran;
import 'package:sabail/ui/pages/screens/surah_screen.dart';
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
      itemCount: Quran.totalSurahCount + 1, 
      itemBuilder: (context, index) {
        if (index == Quran.totalSurahCount) {
         
          return Container(
            height: MediaQuery.of(context).padding.bottom, 
          );
        }
        final surahNumber = index + 1;
        final surahName = Quran.getSurahName(surahNumber);
        final surahEnglishName = Quran.getSurahNameEnglish(surahNumber);
        final surahArabicName = Quran.getSurahNameArabic(surahNumber);
        return ListTile(
          title: Text(
            surahArabicName,
            style: TextStyle(color: Colors.purple.shade500),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                surahName,
                style: TextStyle(color: Colors.purple.shade700),
              ),
              Text(
                surahEnglishName,
                style: TextStyle(color: Colors.purple.shade500),
              ),
            ],
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.purple,
            child: Text(
              '$surahNumber',
              style: const TextStyle(color: Colors.white),
            ),
          ),
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

