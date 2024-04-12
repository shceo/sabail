import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:quran/quran.dart' as Quran;
import 'package:sabail/provider/last_readen_provider.dart';
import 'package:sabail/ui/pages/screens/surah_screen.dart';
import 'package:sabail/ui/theme/app_colors.dart';

class AlQuranPage extends StatelessWidget {
  const AlQuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabailColors.notwhite,
      appBar: AppBar(
        backgroundColor: SabailColors.notwhite,
        title: const Text('Аль Коран'),
      ),
      body: LastReadSurahProvider(
        lastReadSurah: LastReadSurah(),
        child: const BodyAl(),
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
    final myWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: SabailColors.maketPurple,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 120,
          width: myWidth - 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Последнее чтение \n\n${lastReadSurah?.surahName ?? ''}',
                style:  TextStyle(color: SabailColors.notwhite, fontWeight: FontWeight.bold),
              ),
              TextButton(
               onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurahScreen(surahNumber: lastReadSurah?.surahNumber ?? 1), // Open the last read Surah
                    ),
                  );
                },
                child:  const Text(
                  'Продолжить чтение',
                  style: TextStyle(color: Colors.black),
                ),
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
                  lastReadSurah?.setLastReadSurahNumber(surahNumber); 
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
