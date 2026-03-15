import 'package:flutter/material.dart';
import 'package:sabail/src/features/quran/data/models/quran_models.dart';
import 'package:sabail/src/features/quran/presentation/viewmodels/quran_viewmodel.dart';
import 'package:sabail/src/features/quran/presentation/views/surah_detail_screen.dart';

class QuranScreen extends StatefulWidget {
  static const String routeName = '/quran';
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen>
    with SingleTickerProviderStateMixin {
  final QuranViewModel _vm = QuranViewModel();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      _vm.setTab(_tabController.index);
    });
    _vm.loadSurahs();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _vm,
          builder: (context, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),
                const SizedBox(height: 12),
                // Recently read section
                _buildRecentlyRead(),
                const SizedBox(height: 16),
                // Section title
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Список сур и джузов',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Tabs
                _buildTabs(),
                const SizedBox(height: 8),
                // Content
                Expanded(child: _buildContent()),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Коран',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyRead() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Недавно прочтённые',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 64,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _RecentCard(
                verse: '1:1',
                name: 'аль-Фатиха',
                page: 'СТР. 1',
                onTap: () => _openSurah(1),
              ),
              const SizedBox(width: 10),
              _RecentCard(
                verse: '2:1',
                name: 'аль-Бакара',
                page: 'СТР. 2',
                onTap: () => _openSurah(2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.circular(25),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: const Color(0xFF2FC07F),
            borderRadius: BorderRadius.circular(25),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          tabs: const [
            Tab(text: 'Суры'),
            Tab(text: 'Джуз'),
            Tab(text: 'Закладки'),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_vm.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF2FC07F)),
      );
    }
    if (_vm.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _vm.error!,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2FC07F),
              ),
              onPressed: () => _vm.loadSurahs(),
              child: const Text('Повторить',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    return TabBarView(
      controller: _tabController,
      children: [
        _buildSurahList(),
        _buildJuzList(),
        _buildBookmarksList(),
      ],
    );
  }

  Widget _buildSurahList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      itemCount: _vm.surahs.length,
      itemBuilder: (context, index) {
        final surah = _vm.surahs[index];
        final bool isFirstInJuz = _isFirstSurahInJuz(surah.number);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isFirstInJuz)
              _JuzHeader(juzNumbers: _getJuzHeaderNumbers(surah.number)),
            _SurahTile(
              surah: surah,
              onTap: () => _openSurah(surah.number),
            ),
          ],
        );
      },
    );
  }

  Widget _buildJuzList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 4),
      itemCount: JuzData.allJuz.length,
      itemBuilder: (context, index) {
        final juz = JuzData.allJuz[index];
        final ref = juz.surahRefs.first;
        return _JuzTile(
          juzNumber: juz.number,
          surahName: ref.surahName,
          startAyah: '${ref.surahNumber}:${ref.startAyah}',
          onTap: () => _openSurah(ref.surahNumber),
        );
      },
    );
  }

  Widget _buildBookmarksList() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bookmark_border, color: Colors.white30, size: 48),
          SizedBox(height: 12),
          Text(
            'Закладок пока нет',
            style: TextStyle(color: Colors.white54, fontSize: 16),
          ),
          SizedBox(height: 6),
          Text(
            'Добавляйте аяты в закладки\nпри чтении Корана',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white30, fontSize: 13),
          ),
        ],
      ),
    );
  }

  void _openSurah(int surahNumber) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SurahDetailScreen(surahNumber: surahNumber),
      ),
    );
  }

  bool _isFirstSurahInJuz(int surahNumber) {
    for (final juz in JuzData.allJuz) {
      if (juz.surahRefs.first.surahNumber == surahNumber &&
          juz.surahRefs.first.startAyah == 1) {
        return true;
      }
    }
    return false;
  }

  List<int> _getJuzHeaderNumbers(int surahNumber) {
    final List<int> nums = [];
    for (final juz in JuzData.allJuz) {
      if (juz.surahRefs.first.surahNumber == surahNumber &&
          juz.surahRefs.first.startAyah == 1) {
        nums.add(juz.number);
      }
    }
    return nums.isEmpty ? [1] : nums;
  }
}

// ─── Recently read card ─────────────────────────────────────────────
class _RecentCard extends StatelessWidget {
  final String verse;
  final String name;
  final String page;
  final VoidCallback onTap;

  const _RecentCard({
    required this.verse,
    required this.name,
    required this.page,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF1A3D2F),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2FC07F), width: 1.2),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF2FC07F)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                verse,
                style: const TextStyle(
                  color: Color(0xFF2FC07F),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  page,
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
            const SizedBox(width: 10),
            const Icon(Icons.chevron_right, color: Color(0xFF2FC07F), size: 20),
          ],
        ),
      ),
    );
  }
}

// ─── Juz header row ──────────────────────────────────────────────────
class _JuzHeader extends StatelessWidget {
  final List<int> juzNumbers;
  const _JuzHeader({required this.juzNumbers});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: const Color(0xFF1A1A2E),
      child: Text(
        juzNumbers.map((n) => 'Джуз $n').join('\n'),
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ─── Surah list tile ─────────────────────────────────────────────────
class _SurahTile extends StatelessWidget {
  final SurahInfo surah;
  final VoidCallback onTap;

  const _SurahTile({required this.surah, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFF2A2A3E), width: 0.5),
          ),
        ),
        child: Row(
          children: [
            // Number
            SizedBox(
              width: 36,
              child: Text(
                '${surah.number}',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // Progress indicator placeholder
            Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: surah.number == 1
                      ? const Color(0xFF2FC07F)
                      : const Color(0xFF3A3A4E),
                  width: 2,
                ),
              ),
              child: surah.number == 1
                  ? const Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Color(0xFF2FC07F),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
            ),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.russianName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${surah.numberOfAyahs} аятов  •  ${surah.revelationTypeRu}',
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // Arabic name
            Text(
              surah.name,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 22,
                fontFamily: 'serif',
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Juz list tile ───────────────────────────────────────────────────
class _JuzTile extends StatelessWidget {
  final int juzNumber;
  final String surahName;
  final String startAyah;
  final VoidCallback onTap;

  const _JuzTile({
    required this.juzNumber,
    required this.surahName,
    required this.startAyah,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFF2A2A3E), width: 0.5),
          ),
        ),
        child: Row(
          children: [
            // Juz number badge
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF1A3D2F),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '$juzNumber',
                  style: const TextStyle(
                    color: Color(0xFF2FC07F),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Джуз $juzNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$surahName - $startAyah',
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.white24,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
