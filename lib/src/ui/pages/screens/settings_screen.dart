import 'package:flutter/material.dart';
import 'package:sabail/src/domain/api/quran_api.dart' as api;
import 'package:sabail/src/domain/sql/settings_dao.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final settingsDao = SettingsDao();
  bool isDarkTheme = false;
  int selectedTranslation = 131; // По умолчанию: enSaheeh (или другой ID для выбранного языка)
  List<api.Translation> translations = [];

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _fetchTranslations();
  }

  Future<void> _loadSettings() async {
    isDarkTheme = await settingsDao.getTheme();
    selectedTranslation = await settingsDao.getSelectedTranslation() ?? 131;
    setState(() {});
  }

  Future<void> _fetchTranslations() async {
    try {
      final fetched = await api.QuranApiService.fetchTranslations(language: "en");
      // Сортируем переводы по языку
      fetched.sort((a, b) => a.languageName.compareTo(b.languageName));
      setState(() {
        translations = fetched;
      });
    } catch (e) {
      print('Ошибка при получении переводов: $e');
    }
  }

  void _selectTranslation(int id) async {
    setState(() {
      selectedTranslation = id;
      // Перемещаем выбранный перевод в начало списка и сортируем по языку
      translations.sort((a, b) {
        if (a.id == selectedTranslation) return -1;
        if (b.id == selectedTranslation) return 1;
        return a.languageName.compareTo(b.languageName);
      });
    });
    await settingsDao.saveSelectedTranslation(selectedTranslation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Секция темы
            const Text(
              'Тема',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Text('Светлая'),
                  const Spacer(),
                  Switch(
                    value: isDarkTheme,
                    onChanged: (value) async {
                      setState(() {
                        isDarkTheme = value;
                      });
                      await settingsDao.saveTheme(isDarkTheme);
                    },
                  ),
                  const Spacer(),
                  const Text('Тёмная'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Секция переводов
            const Text(
              'Переводы Корана',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Горизонтальный список выбранных языков (по умолчанию – английский)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Chip(
                    label: const Text('English'),
                    backgroundColor: selectedTranslation == 131 ? Colors.blueAccent : Colors.grey,
                  ),
                  // Можно добавить другие выбранные языки, если поддерживаются
                ],
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: translations.length,
              itemBuilder: (context, index) {
                final translation = translations[index];
                final isSelected = translation.id == selectedTranslation;
                return ListTile(
                  title: Text('${translation.name} (${translation.languageName})'),
                  trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
                  onTap: () => _selectTranslation(translation.id),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
