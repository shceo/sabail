import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as Quran;

class ReadingModeScreen extends StatelessWidget {
  final int surahNumber;
  final bool isDarkTheme;
  final int lastReadVerse;

  const ReadingModeScreen({
    super.key,
    required this.surahNumber,
    required this.isDarkTheme,
    required this.lastReadVerse,
  });

  @override
  Widget build(BuildContext context) {
    final surahName = Quran.getSurahName(surahNumber);
    final verseCount = Quran.getVerseCount(surahNumber);

    // Сколько аятов на одной странице
    const int versesPerPage = 15;
    final pageCount = (verseCount / versesPerPage).ceil();

    return Scaffold(
      appBar: AppBar(
        title: Text('$surahName — المصحف الشريف'),
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : Colors.black,
        ),
        titleTextStyle: TextStyle(
          color: isDarkTheme ? Colors.white : Colors.black,
          fontSize: 20,
        ),
      ),
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      body: Directionality(
        textDirection: TextDirection.rtl, // Текст по умолчанию справа налево
        child: PageView.builder(
          controller: PageController(initialPage: (lastReadVerse - 1) ~/ versesPerPage),
          reverse: false, // Самое главное — страницы листаются как в арабской книге (СПРАВА НАЛЕВО)
          scrollDirection: Axis.horizontal,
          itemCount: pageCount,
          itemBuilder: (context, pageIndex) {
            final startVerse = pageIndex * versesPerPage + 1;
            final endVerse = (startVerse + versesPerPage - 1).clamp(1, verseCount);

            return Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkTheme ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDarkTheme ? Colors.white54 : Colors.grey.shade400,
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          'سورة $surahName',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDarkTheme ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(
                          endVerse - startVerse + 1,
                          (index) {
                            final verseNumber = startVerse + index;
                            final verseText = Quran.getVerse(surahNumber, verseNumber);
                            final verseEndSymbol = Quran.getVerseEndSymbol(verseNumber, arabicNumeral: true);

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                '$verseText $verseEndSymbol',
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 19,
                                  height: 2.3,
                                  color: isDarkTheme ? Colors.white : Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
