import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as Quran;

class SurahScreen extends StatelessWidget {
  final int surahNumber;

  const SurahScreen({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    final surahName = Quran.getSurahName(surahNumber);
    final verseCount = Quran.getVerseCount(surahNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text(surahName),
      ),
      body: ListView.builder(
        itemCount: verseCount,
        itemBuilder: (context, index) {
          final verseText = Quran.getVerse(surahNumber, index + 1);
          final verseNumber = Quran.getVerseEndSymbol(index + 1, arabicNumeral: true); 
          final englishTranslation = Quran.getVerseTranslation(surahNumber, index + 1, translation: Quran.Translation.enSaheeh);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        verseText + '' + verseNumber,
                        style:const TextStyle(fontSize: 30),
                        textDirection: TextDirection.rtl, 
                      ),
                    ),
                  ],
                ),
               const SizedBox(height: 8),
                Text(
                  englishTranslation,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Divider(color: Colors.grey), // Добавляем небольшую линию после каждого английского перевода аята
              ],
            ),
          );
        },
      ),
    );
  }
}
