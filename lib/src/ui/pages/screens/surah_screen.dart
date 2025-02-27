import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as Quran;
import 'package:sabail/src/domain/sql/last_read_dao.dart';
import 'package:sabail/src/domain/sql/settings_dao.dart';

import 'reading_mode_screen.dart';

class SurahScreen extends StatefulWidget {
  final int surahNumber;
  final int initialVerse;

  const SurahScreen({
    super.key,
    required this.surahNumber,
    required this.initialVerse,
  });

  @override
  State<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends State<SurahScreen> {
  final settingsDao = SettingsDao();
  final lastReadDao = LastReadDao();
  final ScrollController _scrollController = ScrollController();

  bool isDarkTheme = false;
  int lastReadVerse = 1;

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _loadLastReadVerse();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialVerse > 1) {
        _scrollToVerse(widget.initialVerse);
      }
    });

    _scrollController.addListener(_handleScroll);
  }

  Future<void> _loadTheme() async {
    isDarkTheme = await settingsDao.getTheme();
    setState(() {});
  }

  Future<void> _loadLastReadVerse() async {
    final lastRead = await lastReadDao.getLastRead();
    if (lastRead != null && lastRead['surah_number'] == widget.surahNumber) {
      setState(() {
        lastReadVerse = lastRead['verse_number'] ?? 1;
      });
    } else {
      setState(() {
        lastReadVerse = 1;
      });
    }
  }

  void _scrollToVerse(int verseNumber) {
    const verseHeight = 130.0;
    final offset = (verseNumber - 1) * verseHeight;
    _scrollController.jumpTo(offset.clamp(0, _scrollController.position.maxScrollExtent));
  }

  void _handleScroll() {
    const verseHeight = 130.0;
    final visibleVerse = (_scrollController.offset / verseHeight).floor() + 1;

    if (visibleVerse != lastReadVerse && visibleVerse > 0) {
      setState(() {
        lastReadVerse = visibleVerse;
      });
      _saveLastReadVerse(visibleVerse);
    }
  }

  Future<void> _saveLastReadVerse(int verseNumber) async {
    await lastReadDao.saveLastRead(widget.surahNumber, verseNumber);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surahName = Quran.getSurahName(widget.surahNumber);
    final verseCount = Quran.getVerseCount(widget.surahNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text('$surahName — $lastReadVerse аят'),
        actions: [
          IconButton(
            icon: Icon(isDarkTheme ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () async {
              setState(() => isDarkTheme = !isDarkTheme);
              await settingsDao.saveTheme(isDarkTheme);
            },
          ),
          IconButton(
            icon: const Icon(Icons.chrome_reader_mode),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReadingModeScreen(
                    surahNumber: widget.surahNumber,
                    isDarkTheme: isDarkTheme,
                    lastReadVerse: lastReadVerse,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: isDarkTheme ? Colors.grey[900] : Colors.white,
      body: ListView.builder(
        controller: _scrollController,
        itemCount: verseCount,
        itemBuilder: (context, index) {
          final verseNumber = index + 1;
          final verseText = Quran.getVerse(widget.surahNumber, verseNumber);
          final verseEndSymbol = Quran.getVerseEndSymbol(verseNumber, arabicNumeral: true);
          final englishTranslation = Quran.getVerseTranslation(
            widget.surahNumber,
            verseNumber,
            translation: Quran.Translation.enSaheeh,
          );

          return GestureDetector(
            onTap: () => _saveLastReadVerse(verseNumber),
            child: Container(
              color: lastReadVerse == verseNumber
                  ? (isDarkTheme ? Colors.blueGrey[700] : Colors.blue[100])
                  : Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$verseText$verseEndSymbol',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 30,
                      color: isDarkTheme ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    englishTranslation,
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkTheme ? Colors.grey[400] : Colors.grey[800],
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
