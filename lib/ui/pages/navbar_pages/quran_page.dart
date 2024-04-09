import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as Quran;
import 'package:sabail/provider/last_readen_provider.dart';
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
      body: LastReadSurahProvider(
        lastReadSurah: LastReadSurah(),
        child: BodyAl(),
      ),
    );
  }
}

class BodyAl extends StatelessWidget {
  const BodyAl({super.key});

  @override
  Widget build(BuildContext context) {
    final lastReadSurahProvider = LastReadSurahProvider.watch(context);
    final lastReadSurah = lastReadSurahProvider?.lastReadSurah;
    final lastReadAyah = lastReadSurah?.ayahNumber;
final myWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: SabailColors.darkpurple.withOpacity(0.9),
            borderRadius: BorderRadius.circular(15),
          ),
          height: 120,
          width: myWidth - 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Последнее чтение \n\n${lastReadSurah?.surahName ?? ''} \nАят: ${lastReadAyah ?? ''}', // Display the last read Surah and Ayah
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),

            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: Quran.totalSurahCount,
            itemBuilder: (context, index) {
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
                  lastReadSurah?.setLastReadSurah(surahName); 
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurahScreen(surahNumber: surahNumber),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}