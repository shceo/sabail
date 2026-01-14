import 'package:flutter/material.dart';
import 'package:sabail/src/core/widgets/glass_container.dart';

class QuranToolArgs {
  final String id;
  const QuranToolArgs(this.id);
}

class QuranToolScreen extends StatelessWidget {
  static const String routeName = '/quran/tool';
  final QuranToolDefinition definition;

  const QuranToolScreen({super.key, required this.definition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F5D46), Color(0xFF2FC07F), Color(0xFF7AE2B3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      definition.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GlassContainer(
                padding: const EdgeInsets.all(18),
                borderRadius: BorderRadius.circular(24),
                child: Text(
                  definition.subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              for (final section in definition.sections) ...[
                _SectionCard(section: section),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class QuranToolCatalog {
  static const List<QuranToolDefinition> items = [
    QuranToolDefinition(
      id: 'bookmarks',
      title: 'Bookmarks',
      subtitle: 'Saved ayahs with quick access and notes.',
      sections: [
        QuranToolSection(
          title: 'Recent bookmarks',
          items: [
            'Al-Baqarah 2:255',
            'Al-Kahf 18:10',
            'Ar-Rahman 55:13',
          ],
        ),
        QuranToolSection(
          title: 'Tags',
          items: [
            'Morning review',
            'Memorization',
            'Favorites',
          ],
        ),
      ],
    ),
    QuranToolDefinition(
      id: 'plan',
      title: 'Reading plan',
      subtitle: 'Stay on track with a steady daily schedule.',
      sections: [
        QuranToolSection(
          title: 'Today',
          items: [
            'Juz 5: 1-20',
            'Estimated time: 18 min',
            'Reminder at 20:30',
          ],
        ),
        QuranToolSection(
          title: 'Progress',
          items: [
            '4/30 days completed',
            'Current streak: 3 days',
            'Weekly goal: 7 days',
          ],
        ),
      ],
    ),
    QuranToolDefinition(
      id: 'daily',
      title: 'Daily ayah',
      subtitle: 'A short daily reflection to keep close.',
      sections: [
        QuranToolSection(
          title: 'Verse of the day',
          items: [
            'Share with friends',
            'Save to favorites',
            'Add a personal note',
          ],
        ),
        QuranToolSection(
          title: 'Reminders',
          items: [
            'Morning notification',
            'Evening review',
            'Weekend recap',
          ],
        ),
      ],
    ),
    QuranToolDefinition(
      id: 'about',
      title: 'Quran data & API',
      subtitle: 'Sources, translations, and metadata.',
      sections: [
        QuranToolSection(
          title: 'Sources',
          items: [
            'Verified Arabic text',
            'Multiple translations',
            'Audio recitations',
          ],
        ),
        QuranToolSection(
          title: 'Updates',
          items: [
            'Monthly data refresh',
            'Offline cache support',
            'Sync on Wi-Fi',
          ],
        ),
      ],
    ),
  ];

  static QuranToolDefinition byId(String id) {
    return items.firstWhere(
      (item) => item.id == id,
      orElse: () => items.first,
    );
  }
}

class QuranToolDefinition {
  final String id;
  final String title;
  final String subtitle;
  final List<QuranToolSection> sections;

  const QuranToolDefinition({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.sections,
  });
}

class QuranToolSection {
  final String title;
  final List<String> items;

  const QuranToolSection({required this.title, required this.items});
}

class _SectionCard extends StatelessWidget {
  final QuranToolSection section;
  const _SectionCard({required this.section});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          for (final item in section.items) ...[
            _BulletItem(text: item),
            const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;
  const _BulletItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Colors.white70,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
