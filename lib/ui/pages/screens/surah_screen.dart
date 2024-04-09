import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as Quran;

class SurahScreen extends StatelessWidget {
  final int surahNumber;

  const SurahScreen({Key? key, required this.surahNumber}) : super(key: key);

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
          final verseNumber = Quran.getVerseEndSymbol(index + 1, arabicNumeral: true); // номер аята на арабском и внутри круглого знака
          final englishTranslation = Quran.getVerseTranslation(surahNumber, index + 1, translation: Quran.Translation.enSaheeh); // английский перевод аята

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40, // ширина контейнера для номера аята
                      alignment: Alignment.center,
                      child: Text(
                        verseNumber,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        verseText,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  englishTranslation,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
