import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabail/src/components/tabbar/custom_tabbar.dart';
import 'package:sabail/src/provider/last_readen_provider.dart';
import 'package:sabail/src/ui/pages/screens/surah_screen.dart';
import 'package:sabail/src/ui/theme/app_colors.dart';
import 'package:quran/quran.dart' as Quran;
import 'package:sabail/src/provider/surah_cache_provider.dart';

class AlQuranPage extends StatelessWidget {
  const AlQuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SurahCacheProvider()..loadSurahs(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: SabailColors.notwhite,
          appBar: AppBar(
            backgroundColor: SabailColors.notwhite,
            title: const Text('[81:27] إِنْ هُوَ إِلَّا ذِكْرٌ لِلْعَالَمِينَ'),
            centerTitle: true,
          ),
          body: LastReadSurahProvider(
            lastReadSurah: LastReadSurah(),
            child: const BodyAl(),
          ),
        ),
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
    final surahCache = Provider.of<SurahCacheProvider>(context);
    final myWidth = MediaQuery.of(context).size.width;

    final lastReadTitle = (lastReadSurah?.surahName != null && lastReadSurah?.verseNumber != null)
        ? '${lastReadSurah?.surahName} - ${lastReadSurah?.verseNumber} аят'
        : 'Нет данных о последнем чтении';

    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                color: SabailColors.lightpurple,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 120,
              width: myWidth - 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Последнее чтение\n\n$lastReadTitle',
                    style: TextStyle(
                      color: SabailColors.notwhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (lastReadSurah?.surahNumber != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SurahScreen(
                              surahNumber: lastReadSurah!.surahNumber,
                              initialVerse: lastReadSurah.verseNumber, 
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Продолжить чтение',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 184,
              child: Image.asset(
                'assets/images/quran.png',
                fit: BoxFit.cover,
                width: 200,
              ),
            ),
          ],
        ),
        const CustomTabBar(),
        Expanded(
          child: TabBarView(
            children: [
              _buildSurahList(context, surahCache),
              _buildJuzList(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSurahList(BuildContext context, SurahCacheProvider surahCache) {
    return ListView.builder(
      itemCount: surahCache.surahs.length + 2,  // +2 для пустых контейнеров
      itemBuilder: (context, index) {
        if (index >= surahCache.surahs.length) {
          return const SizedBox(height: 60); // Пустое место для учета навбара
        }

        final surah = surahCache.surahs[index];
        return ListTile(
          title: Text(
            surah.arabicName,
            style: const TextStyle(color: Colors.black),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(surah.name, style: const TextStyle(color: Colors.black)),
              Text(surah.englishName, style: const TextStyle(color: Colors.black)),
            ],
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.purple,
            child: Text(
              '${surah.number}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          onTap: () {
            final lastReadSurah = LastReadSurahProvider.watch(context)?.lastReadSurah;

            Future.microtask(() {
              lastReadSurah?.setLastReadSurah(surah.name);
              lastReadSurah?.setLastReadSurahNumber(surah.number);
              lastReadSurah?.setLastReadVerse(1); // Открыли суру с первого аята
            });

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SurahScreen(
                  surahNumber: surah.number,
                  initialVerse: 1, // Начинаем с первого аята при новом открытии
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildJuzList(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        final juzNumber = index + 1;
        return ListTile(
          title: Text(
            'Джуз $juzNumber',
            style: const TextStyle(color: Colors.black),
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.purple,
            child: Text(
              '$juzNumber',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => JuzDetailScreen(juzNumber: juzNumber),
              ),
            );
          },
        );
      },
    );
  }
}

class JuzDetailScreen extends StatelessWidget {
  final int juzNumber;

  const JuzDetailScreen({super.key, required this.juzNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Джуз $juzNumber')),
      body: FutureBuilder<List<int>>(
        future: _loadSurahsForJuz(juzNumber),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final surahNumbers = snapshot.data!;
          return ListView.builder(
            itemCount: surahNumbers.length,
            itemBuilder: (context, index) {
              final surahNumber = surahNumbers[index];
              final surahName = Quran.getSurahName(surahNumber);
              final surahEnglishName = Quran.getSurahNameEnglish(surahNumber);
              final surahArabicName = Quran.getSurahNameArabic(surahNumber);

              return ListTile(
                title: Text(surahArabicName, style: const TextStyle(color: Colors.black)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(surahName, style: const TextStyle(color: Colors.black)),
                    Text(surahEnglishName, style: const TextStyle(color: Colors.black)),
                  ],
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text('$surahNumber', style: const TextStyle(color: Colors.white)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SurahScreen(
                        surahNumber: surahNumber,
                        initialVerse: 1,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<int>> _loadSurahsForJuz(int juzNumber) async {
    return List.generate(Quran.totalSurahCount, (i) => i + 1)
        .where((i) => Quran.getJuzNumber(i, 1) == juzNumber)
        .toList();
  }
}
