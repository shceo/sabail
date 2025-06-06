import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabail/src/presentation/widgets/custom_tabbar.dart';
import 'package:sabail/src/domain/api/quran_api.dart' as api;
import 'package:sabail/src/cubit/last_read_cubit.dart';
import 'package:sabail/src/ui/pages/screens/surah_screen.dart';
import 'package:sabail/src/presentation/app/app_colors.dart';
import 'package:sabail/src/cubit/surah_cache_cubit.dart';

class AlQuranPage extends StatelessWidget {
  const AlQuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SurahCacheCubit()..loadSurahs(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: SabailColors.notwhite,
          appBar: AppBar(
            backgroundColor: SabailColors.notwhite,
            title: const Text('[81:27] إِنْ هُوَ إِلَّا ذِكْرٌ لِلْعَالَمِينَ'),
            centerTitle: true,
          ),
          body: BlocProvider(
            create: (_) => LastReadCubit(),
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
    final lastReadCubit = context.watch<LastReadCubit>();
    final lastReadSurah = lastReadCubit.state;
    final surahCache = context.watch<SurahCacheCubit>().state;
    final myWidth = MediaQuery.of(context).size.width;

    final lastReadTitle =
        (lastReadSurah?.surahName != null && lastReadSurah?.verseNumber != null)
        ? '${lastReadSurah!.surahName} - ${lastReadSurah.verseNumber} аят'
        : 'Нет данных о последнем чтении';

    return Column(
      children: [
        // Верхняя часть страницы с информацией о последнем чтении
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
                  ),
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
              _buildJuzList(context, surahCache),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSurahList(BuildContext context, SurahCacheState surahCache) {
    return ListView.builder(
      itemCount: surahCache.surahs.length + 2,
      itemBuilder: (context, index) {
        if (index >= surahCache.surahs.length) {
          return const SizedBox(height: 60);
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
              Text(
                surah.englishName,
                style: const TextStyle(color: Colors.black),
              ),
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
            final cubit = context.read<LastReadCubit>();
            Future.microtask(() {
              cubit.setLastReadSurah(surah.name);
              cubit.setLastReadSurahNumber(surah.number);
              cubit.setLastReadVerse(1);
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    SurahScreen(surahNumber: surah.number, initialVerse: 1),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildJuzList(BuildContext context, SurahCacheState surahCache) {
    return FutureBuilder<List<api.JuzDetail>>(
      future: api.QuranApiService.fetchJuzDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        }
        final juzDetails = snapshot.data!;
        return ListView.builder(
          itemCount: juzDetails.length,
          itemBuilder: (context, index) {
            final juzDetail = juzDetails[index];
            // Фильтруем сур из кэша по номерам, полученным для данного джуза
            final surahsForJuz = surahCache.surahs
                .where((s) => juzDetail.surahNumbers.contains(s.number))
                .toList();
            return ListTile(
              title: Text(
                'Джуз ${juzDetail.juzNumber}',
                style: const TextStyle(color: Colors.black),
              ),
              subtitle: surahsForJuz.isNotEmpty
                  ? Text(
                      surahsForJuz
                          .map(
                            (s) => s.englishName.isNotEmpty
                                ? s.englishName
                                : s.name,
                          )
                          .join(', '),
                      style: const TextStyle(color: Colors.black),
                    )
                  : const Text(
                      'Нет данных',
                      style: TextStyle(color: Colors.black),
                    ),
              leading: CircleAvatar(
                backgroundColor: Colors.purple,
                child: Text(
                  '${juzDetail.juzNumber}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JuzDetailScreen(
                      juzNumber: juzDetail.juzNumber,
                      surahs: surahsForJuz,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class JuzDetailScreen extends StatelessWidget {
  final int juzNumber;
  final List<api.Surah> surahs;

  const JuzDetailScreen({
    super.key,
    required this.juzNumber,
    required this.surahs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Джуз $juzNumber')),
      body: ListView.builder(
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          final surah = surahs[index];
          return ListTile(
            title: Text(
              surah.arabicName,
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(surah.name, style: const TextStyle(color: Colors.black)),
                Text(
                  surah.englishName,
                  style: const TextStyle(color: Colors.black),
                ),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      SurahScreen(surahNumber: surah.number, initialVerse: 1),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
