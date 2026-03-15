import 'package:flutter/material.dart';
import 'package:sabail/src/features/quran/data/models/quran_models.dart';
import 'package:sabail/src/features/quran/data/quran_service.dart';

class SurahDetailScreen extends StatefulWidget {
  final int surahNumber;

  const SurahDetailScreen({super.key, required this.surahNumber});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  final QuranService _service = QuranService();
  List<Ayah> _arabicAyahs = [];
  List<Ayah> _translationAyahs = [];
  bool _isLoading = true;
  String? _error;
  bool _showTranslation = true;
  String _surahName = '';

  @override
  void initState() {
    super.initState();
    _loadData();
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
      // Get surah name from static map
      _surahName =
          SurahInfo.surahNamesRu[widget.surahNumber] ?? 'Сура ${widget.surahNumber}';
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Ошибка загрузки: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        foregroundColor: Colors.white,
        title: Text(
          _surahName.isEmpty ? 'Сура ${widget.surahNumber}' : _surahName,
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _showTranslation ? Icons.translate : Icons.translate,
              color: _showTranslation
                  ? const Color(0xFF2FC07F)
                  : Colors.white54,
            ),
            tooltip: 'Перевод',
            onPressed: () =>
                setState(() => _showTranslation = !_showTranslation),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
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
              child:
                  const Text('Повторить', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: _arabicAyahs.length,
      itemBuilder: (context, index) {
        final arabic = _arabicAyahs[index];
        final translation =
            index < _translationAyahs.length ? _translationAyahs[index] : null;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF2A2A3E), width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Ayah number badge
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A3D2F),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${arabic.numberInSurah}',
                        style: const TextStyle(
                          color: Color(0xFF2FC07F),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Page number
                  Text(
                    'стр. ${arabic.page}',
                    style: const TextStyle(
                      color: Colors.white24,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Arabic text
              Text(
                arabic.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  height: 1.8,
                  fontFamily: 'serif',
                ),
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              // Translation
              if (_showTranslation && translation != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF151520),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    translation.text,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
