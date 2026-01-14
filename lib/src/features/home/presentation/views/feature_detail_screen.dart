import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabail/src/core/widgets/glass_container.dart';

class FeatureDetailArgs {
  final String id;
  const FeatureDetailArgs(this.id);
}

class FeatureDetailScreen extends StatelessWidget {
  static const String routeName = '/feature';
  final FeatureDefinition definition;

  const FeatureDetailScreen({super.key, required this.definition});

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
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: Center(
                        child: FaIcon(
                          definition.icon,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        definition.subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
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

class FeatureCatalog {
  static const List<FeatureDefinition> items = [
    FeatureDefinition(
      id: 'kalma',
      title: 'Kalma',
      subtitle: 'Daily kalma list, short meanings, and practice plan.',
      icon: FontAwesomeIcons.handPointUp,
      sections: [
        FeatureSection(
          title: 'Daily list',
          icon: Icons.list_alt,
          items: [
            'Kalma 1: Tayyibah',
            'Kalma 2: Shahada',
            'Kalma 3: Tamjeed',
            'Kalma 4: Tauheed',
            'Kalma 5: Istighfar',
            'Kalma 6: Radde Kufr',
          ],
        ),
        FeatureSection(
          title: 'Practice plan',
          icon: Icons.schedule,
          items: [
            'Morning recitation',
            'After prayer review',
            'Before sleep reminder',
          ],
        ),
        FeatureSection(
          title: 'Tips',
          icon: Icons.lightbulb_outline,
          items: [
            'Read with meaning once',
            'Repeat in sets of 7',
            'Track your weekly streak',
          ],
        ),
      ],
    ),
    FeatureDefinition(
      id: 'quran',
      title: 'Al Quran',
      subtitle: 'Surahs, ayahs, bookmarks, and daily reading.',
      icon: FontAwesomeIcons.bookQuran,
      sections: [
        FeatureSection(
          title: 'Continue reading',
          icon: Icons.play_circle_outline,
          items: [
            'Last read: Al-Kahf',
            'Plan: 1 juz per day',
            'Daily ayah reminder',
          ],
        ),
        FeatureSection(
          title: 'Quick access',
          icon: Icons.bookmark_border,
          items: [
            'Bookmarks',
            'Notes',
            'Translations',
          ],
        ),
      ],
    ),
    FeatureDefinition(
      id: 'hadith',
      title: 'Al Hadith',
      subtitle: 'Browse collections and daily curated topics.',
      icon: FontAwesomeIcons.book,
      sections: [
        FeatureSection(
          title: 'Collections',
          icon: Icons.menu_book,
          items: [
            'Sahih Bukhari',
            'Sahih Muslim',
            'Jami At-Tirmidhi',
            'Sunan Abu Dawood',
            'Sunan An-Nasai',
          ],
        ),
        FeatureSection(
          title: 'Topics',
          icon: Icons.local_library,
          items: [
            'Faith',
            'Prayer',
            'Charity',
            'Family',
          ],
        ),
        FeatureSection(
          title: 'Daily pick',
          icon: Icons.auto_awesome,
          items: [
            'Short hadith of the day',
            'Save to favorites',
            'Share with friends',
          ],
        ),
      ],
    ),
    FeatureDefinition(
      id: 'asma',
      title: 'Asma Ul Husna',
      subtitle: 'Learn the 99 names with reflections and reminders.',
      icon: FontAwesomeIcons.heartPulse,
      sections: [
        FeatureSection(
          title: 'Names of mercy',
          icon: Icons.favorite_border,
          items: [
            'Ar-Rahman',
            'Ar-Rahim',
            'Al-Ghaffar',
          ],
        ),
        FeatureSection(
          title: 'Names of power',
          icon: Icons.shield_outlined,
          items: [
            'Al-Qadir',
            'Al-Aziz',
            'Al-Jabbar',
          ],
        ),
        FeatureSection(
          title: 'Study plan',
          icon: Icons.checklist,
          items: [
            'Name of the day',
            'Reflection notes',
            'Weekly review',
          ],
        ),
      ],
    ),
    FeatureDefinition(
      id: 'tasbih',
      title: 'Tasbih',
      subtitle: 'Custom sessions with presets and history.',
      icon: FontAwesomeIcons.repeat,
      sections: [
        FeatureSection(
          title: 'Current session',
          icon: Icons.timelapse,
          items: [
            'SubhanAllah x33',
            'Alhamdulillah x33',
            'Allahu Akbar x34',
          ],
        ),
        FeatureSection(
          title: 'Presets',
          icon: Icons.layers_outlined,
          items: [
            'Morning dhikr',
            'Evening dhikr',
            'After prayer',
          ],
        ),
        FeatureSection(
          title: 'History',
          icon: Icons.history,
          items: [
            'Last 7 sessions',
            'Weekly totals',
            'Most used presets',
          ],
        ),
      ],
    ),
    FeatureDefinition(
      id: 'qibla',
      title: 'Qibla Compass',
      subtitle: 'Calibrated direction guide with nearby places.',
      icon: FontAwesomeIcons.compass,
      sections: [
        FeatureSection(
          title: 'Calibration',
          icon: Icons.explore,
          items: [
            'Move phone in a figure eight',
            'Keep away from metal',
            'Hold level for accuracy',
          ],
        ),
        FeatureSection(
          title: 'Direction',
          icon: Icons.navigation_outlined,
          items: [
            'Facing Qibla indicator',
            'Distance to Kaaba estimate',
            'Local magnetic declination',
          ],
        ),
        FeatureSection(
          title: 'Nearby',
          icon: Icons.place_outlined,
          items: [
            'Nearest mosques list',
            'Open in maps',
            'Saved places',
          ],
        ),
      ],
    ),
    FeatureDefinition(
      id: 'siyam',
      title: 'Siyam Timing',
      subtitle: 'Fasting schedule and reminders.',
      icon: FontAwesomeIcons.moon,
      sections: [
        FeatureSection(
          title: 'Today',
          icon: Icons.wb_twilight,
          items: [
            'Suhoor: 04:12',
            'Iftar: 18:07',
            'Fajr alert enabled',
          ],
        ),
        FeatureSection(
          title: 'Weekly plan',
          icon: Icons.view_week,
          items: [
            'Mon/Thu Sunnah',
            'White days',
            'Custom fasting days',
          ],
        ),
        FeatureSection(
          title: 'Reminders',
          icon: Icons.notifications_active_outlined,
          items: [
            'Pre-dawn alert',
            'Iftar alert',
            'Hydration reminder',
          ],
        ),
      ],
    ),
    FeatureDefinition(
      id: 'dua',
      title: 'Dua for Everyday',
      subtitle: 'Curated duas for daily moments and travel.',
      icon: FontAwesomeIcons.handsPraying,
      sections: [
        FeatureSection(
          title: 'Morning & evening',
          icon: Icons.wb_sunny_outlined,
          items: [
            'Morning adhkar',
            'Evening adhkar',
            'Sleep dua',
          ],
        ),
        FeatureSection(
          title: 'Travel',
          icon: Icons.flight_takeoff,
          items: [
            'Start travel dua',
            'Return dua',
            'Safety reminder',
          ],
        ),
        FeatureSection(
          title: 'Home',
          icon: Icons.home_outlined,
          items: [
            'Enter home',
            'Leave home',
            'Before meals',
          ],
        ),
      ],
    ),
    FeatureDefinition(
      id: 'hajj',
      title: 'Hajj & Umrah',
      subtitle: 'Step-by-step guide and checklists.',
      icon: FontAwesomeIcons.kaaba,
      sections: [
        FeatureSection(
          title: 'Umrah steps',
          icon: Icons.directions_walk,
          items: [
            'Ihram',
            'Tawaf',
            "Sa'i",
            'Halq/Taqsir',
          ],
        ),
        FeatureSection(
          title: 'Hajj days',
          icon: Icons.calendar_today,
          items: [
            '8-13 Dhul Hijjah',
            'Arafah day',
            'Mina & Jamarat',
          ],
        ),
        FeatureSection(
          title: 'Checklist',
          icon: Icons.check_circle_outline,
          items: [
            'Documents',
            'Clothing',
            'Health essentials',
          ],
        ),
      ],
    ),
  ];

  static FeatureDefinition byId(String id) {
    return items.firstWhere(
      (item) => item.id == id,
      orElse: () => items.first,
    );
  }
}

class FeatureDefinition {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<FeatureSection> sections;

  const FeatureDefinition({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.sections,
  });
}

class FeatureSection {
  final String title;
  final IconData icon;
  final List<String> items;

  const FeatureSection({
    required this.title,
    required this.icon,
    required this.items,
  });
}

class _SectionCard extends StatelessWidget {
  final FeatureSection section;
  const _SectionCard({required this.section});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(section.icon, color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              Text(
                section.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
