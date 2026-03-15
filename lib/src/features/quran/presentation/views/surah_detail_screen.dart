import 'package:flutter/material.dart';
import 'package:sabail/src/features/quran/data/models/quran_models.dart';
import 'package:sabail/src/features/quran/data/quran_service.dart';

/// Reading modes
enum ReadingMode { ayahByAyah, book }

class SurahDetailScreen extends StatefulWidget {
  final int surahNumber;

  const SurahDetailScreen({super.key, required this.surahNumber});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  final QuranService _service = QuranService();

  // Data
  List<Ayah> _arabicAyahs = [];
  List<Ayah> _translationAyahs = [];
  bool _isLoading = true;
  String? _error;

  // State
  ReadingMode _mode = ReadingMode.ayahByAyah;
  bool _showTranslation = true;
  String _surahName = '';
  String _surahArabicName = '';
  int _currentPage = 1;
  int _juz = 1;
  int _hizb = 1;

  // Book mode — page data cache
  final Map<int, List<Ayah>> _pageCache = {};
  late PageController _pageController;
  int _startPage = 1; // first page of surah
  int _endPage = 1; // last page of surah

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final results = await Future.wait([
        _service.fetchSurahArabic(widget.surahNumber),
        _service.fetchSurahTranslation(widget.surahNumber),
      ]);
      _arabicAyahs = results[0];
      _translationAyahs = results[1];

      _surahName = SurahInfo.surahNamesRu[widget.surahNumber] ??
          'Сура ${widget.surahNumber}';
      if (_arabicAyahs.isNotEmpty) {
        _surahArabicName =
            _arabicAyahs.first.surahName ?? '';
        _currentPage = _arabicAyahs.first.page;
        _startPage = _arabicAyahs.first.page;
        _endPage = _arabicAyahs.last.page;
        _juz = _arabicAyahs.first.juz;
        _hizb = ((_arabicAyahs.first.hizbQuarter ?? 1) / 4).ceil();
      }

      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Ошибка загрузки';
      });
    }
  }

  Future<List<Ayah>> _getPageData(int page) async {
    if (_pageCache.containsKey(page)) return _pageCache[page]!;
    final ayahs = await _service.fetchPage(page);
    _pageCache[page] = ayahs;
    return ayahs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // Top header bar
            _buildTopBar(),
            // Content
            Expanded(child: _buildContent()),
            // Bottom toolbar
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  // ─── Top bar (like screenshots) ───────────────────────────────────
  Widget _buildTopBar() {
    return Container(
      color: const Color(0xFF1A1A2E),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF252538),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _surahName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Страница $_currentPage | Джуз $_juz | Хизб $_hizb',
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.white54),
            onPressed: () {},
          ),
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

  // ─── Content area ─────────────────────────────────────────────────
  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF2FC07F)),
      );
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!,
                style: const TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2FC07F),
              ),
              onPressed: _loadData,
              child: const Text('Повторить',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    return _mode == ReadingMode.ayahByAyah
        ? _buildAyahByAyahMode()
        : _buildBookMode();
  }

  // ─── Ayah-by-ayah mode (vertical scroll) ──────────────────────────
  Widget _buildAyahByAyahMode() {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: _arabicAyahs.length + 1, // +1 for surah header
      itemBuilder: (context, index) {
        if (index == 0) return _buildSurahBanner();
        final i = index - 1;
        final arabic = _arabicAyahs[i];
        final translation =
            i < _translationAyahs.length ? _translationAyahs[i] : null;
        return _buildAyahTile(arabic, translation);
      },
    );
  }

  /// Decorative surah header banner
  Widget _buildSurahBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24, width: 1),
        borderRadius: BorderRadius.circular(4),
        image: const DecorationImage(
          image: AssetImage('assets/images/surah_banner.png'),
          fit: BoxFit.cover,
          opacity: 0.15,
        ),
      ),
      child: Center(
        child: Text(
          _surahArabicName.isNotEmpty
              ? 'سُورَةُ ${_surahArabicName.replaceAll('سُورَةُ ', '')}'
              : 'سُورَة',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'serif',
          ),
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }

  /// Single ayah tile with number, arabic, translation, menu
  Widget _buildAyahTile(Ayah arabic, Ayah? translation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Number row + menu
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: Row(
            children: [
              // Ayah number badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xFF2FC07F), width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${widget.surahNumber}:${arabic.numberInSurah}',
                  style: const TextStyle(
                    color: Color(0xFF2FC07F),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              // Three-dot menu
              GestureDetector(
                onTap: () => _showAyahMenu(arabic),
                child: const Icon(Icons.more_vert,
                    color: Colors.white30, size: 20),
              ),
            ],
          ),
        ),
        // Arabic text — centered
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            arabic.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              height: 1.9,
              fontFamily: 'serif',
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        ),
        // Translation
        if (_showTranslation && translation != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              translation.text,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        // Divider
        const Divider(color: Color(0xFF2A2A3E), height: 1, thickness: 0.5),
      ],
    );
  }

  void _showAyahMenu(Ayah ayah) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading:
                  const Icon(Icons.bookmark_add, color: Color(0xFF2FC07F)),
              title: const Text('Добавить в закладки',
                  style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.white54),
              title: const Text('Поделиться',
                  style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.copy, color: Colors.white54),
              title: const Text('Копировать текст',
                  style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Book mode (horizontal page scroll) ───────────────────────────
  Widget _buildBookMode() {
    final totalPages = _endPage - _startPage + 1;
    return PageView.builder(
      controller: _pageController,
      reverse: true, // RTL — swipe like a real Quran
      itemCount: totalPages,
      onPageChanged: (index) {
        setState(() => _currentPage = _startPage + index);
      },
      itemBuilder: (context, index) {
        final pageNum = _startPage + index;
        return FutureBuilder<List<Ayah>>(
          future: _getPageData(pageNum),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                !snapshot.hasData) {
              return const Center(
                child:
                    CircularProgressIndicator(color: Color(0xFF2FC07F)),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Ошибка загрузки стр. $pageNum',
                  style: const TextStyle(color: Colors.white54),
                ),
              );
            }
            final ayahs = snapshot.data ?? [];
            return _buildPageContent(pageNum, ayahs);
          },
        );
      },
    );
  }

  Widget _buildPageContent(int pageNum, List<Ayah> ayahs) {
    // Group ayahs by surah for surah headers
    final List<Widget> children = [];

    int? lastSurahNum;
    for (final ayah in ayahs) {
      final surahNum = ayah.surahNumber ?? widget.surahNumber;
      // Add surah header if new surah starts
      if (surahNum != lastSurahNum && ayah.numberInSurah == 1) {
        final arabicName = ayah.surahName ?? '';
        children.add(
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                arabicName.isNotEmpty ? arabicName : 'سُورَة',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'serif',
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
        );
        // Bismillah for non-Fatiha, non-Tawba
        if (surahNum != 1 && surahNum != 9) {
          children.add(
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontFamily: 'serif',
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
          );
        }
        lastSurahNum = surahNum;
      } else if (surahNum != lastSurahNum) {
        lastSurahNum = surahNum;
      }
    }

    // Build flowing Arabic text with ayah markers
    final buffer = StringBuffer();
    for (final ayah in ayahs) {
      buffer.write(ayah.text);
      buffer.write(' ');
    }

    children.add(
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            buffer.toString().trim(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              height: 2.0,
              fontFamily: 'serif',
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );

    // Page number at bottom
    children.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 4),
        child: Center(
          child: Text(
            '$pageNum',
            style: const TextStyle(color: Colors.white38, fontSize: 14),
          ),
        ),
      ),
    );

    return Column(children: children);
  }

  // ─── Bottom toolbar ───────────────────────────────────────────────
  Widget _buildBottomBar() {
    return Container(
      color: const Color(0xFF1A1A2E),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          // Translation toggle (ayah mode only)
          if (_mode == ReadingMode.ayahByAyah)
            _BottomBarButton(
              icon: Icons.translate,
              label: 'Перевод',
              isActive: _showTranslation,
              onTap: () =>
                  setState(() => _showTranslation = !_showTranslation),
            ),
          const Spacer(),
          // Mode toggle button
          _BottomBarButton(
            icon: _mode == ReadingMode.ayahByAyah
                ? Icons.auto_stories
                : Icons.format_list_numbered,
            label: _mode == ReadingMode.ayahByAyah ? 'Книга' : 'Аяты',
            isActive: false,
            onTap: () {
              setState(() {
                _mode = _mode == ReadingMode.ayahByAyah
                    ? ReadingMode.book
                    : ReadingMode.ayahByAyah;
                if (_mode == ReadingMode.book) {
                  _pageController = PageController();
                }
              });
            },
          ),
          const SizedBox(width: 8),
          // Tafsir placeholder
          _BottomBarButton(
            icon: Icons.edit_note,
            label: 'Тафсир',
            isActive: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _BottomBarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomBarButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF2FC07F).withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive ? const Color(0xFF2FC07F) : Colors.white54,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? const Color(0xFF2FC07F) : Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
