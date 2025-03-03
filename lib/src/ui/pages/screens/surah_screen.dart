import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as Quran;
import 'package:sabail/src/domain/sql/last_read_dao.dart';
import 'package:sabail/src/domain/sql/settings_dao.dart';
import 'package:sabail/src/domain/api/quran_api.dart' as api;
import 'reading_mode_screen.dart';
import 'settings_screen.dart';

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
  List<api.Verse> verses = [];

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _loadLastReadVerse();
    _fetchVerses();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialVerse > 1) {
        _scrollToVerse(widget.initialVerse);
      }
    });

    _scrollController.addListener(_handleScroll);
  }

  Future<void> _fetchVerses() async {
    try {
      final selectedTranslation = await settingsDao.getSelectedTranslation() ?? 131;
      // Если выбран перевод для русского, измените language на "ru"
      final language = (selectedTranslation == 79) ? "ru" : "en";
      final fetchedVerses = await api.QuranApiService.fetchSurahVerses(
        widget.surahNumber,
        language: language,
        translationId: selectedTranslation,
      );
      setState(() {
        verses = fetchedVerses;
      });
    } catch (e) {
      print('Ошибка при получении стихов: $e');
      setState(() {
        verses = [];
      });
    }
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
    const verseHeight = 150.0;
    final offset = (verseNumber - 1) * verseHeight;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          offset.clamp(0, _scrollController.position.maxScrollExtent),
        );
      }
    });
  }

  void _handleScroll() {
    const verseHeight = 150.0;
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
    final verseCount = verses.length;
    if (verseCount == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Сура ${widget.surahNumber} — $lastReadVerse аят'),
        ),
        backgroundColor: isDarkTheme ? Colors.grey[900] : Colors.white,
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final surahName = verses.first.verseKey.split(":").first;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkTheme ? Colors.black87 : Colors.grey,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Сура $surahName',
              style: const TextStyle(fontSize: 18),
            ),
            const Text(
              'Страница 3 | Джуз 1 | Хизб 1',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          // Иконка настроек
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
              _loadTheme();
              _fetchVerses();
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
          final verse = verses[index];
          final verseNumber = verse.verseNumber;
          final verseText = verse.textUthmani;
          final englishTranslation = verse.translation ?? "";
          final isCurrentVerse = (lastReadVerse == verseNumber);
          // Получаем символ конца аята через библиотеку Quran (оставляем результат, даже если он возвращает точку)
          final verseEndSymbol = Quran.getVerseEndSymbol(verseNumber, arabicNumeral: true);
          // Если возвращается точка, комбинируем её с арабской нумерацией вручную
          final displayEndSymbol = (verseEndSymbol.trim() == '.') 
              ? '۝ ${toArabicNumeral(verseNumber)}'
              : verseEndSymbol + ' ' + toArabicNumeral(verseNumber);

          return GestureDetector(
            onTap: () => _saveLastReadVerse(verseNumber),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isCurrentVerse
                    ? (isDarkTheme ? Colors.blueGrey[700] : Colors.blue[100])
                    : (isDarkTheme ? Colors.grey[850] : Colors.white),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  if (!isDarkTheme)
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Номер аята (например "2:10")
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: isDarkTheme ? Colors.blueGrey[600] : Colors.blueGrey[200],
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          verse.verseKey,
                          style: TextStyle(
                            color: isDarkTheme ? Colors.white : Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Арабский текст
                  Text(
                    verseText,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 26,
                      color: isDarkTheme ? Colors.white : Colors.black,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Нижняя строка: нумерация с символом и перевод
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        displayEndSymbol,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkTheme ? Colors.grey[300] : Colors.grey[800],
                        ),
                      ),
                      Text(
                        englishTranslation,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDarkTheme ? Colors.grey[300] : Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  
  // Преобразование арабских цифр
  String toArabicNumeral(int number) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number.toString().split('').map((d) => arabicDigits[int.parse(d)]).join('');
  }
}
