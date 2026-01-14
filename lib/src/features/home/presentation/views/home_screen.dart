import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabail/src/core/di/locator.dart';
import 'package:sabail/src/core/widgets/glass_container.dart';
import 'package:sabail/src/features/home/presentation/views/feature_detail_screen.dart';
import 'package:sabail/src/features/prayer_times/presentation/viewmodels/prayer_location_store.dart';
import 'package:sabail/src/features/prayer_times/presentation/views/prayer_time.dart';
import 'package:sabail/src/features/quran/presentation/views/quran_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      _HomeFeature(
        icon: FontAwesomeIcons.handPointUp,
        label: 'Kalma',
        onTap: () => Navigator.of(context).pushNamed(
          FeatureDetailScreen.routeName,
          arguments: const FeatureDetailArgs('kalma'),
        ),
      ),
      _HomeFeature(
        icon: FontAwesomeIcons.bookQuran,
        label: 'Al Quran',
        onTap: () => Navigator.of(context).pushNamed(QuranScreen.routeName),
      ),
      _HomeFeature(
        icon: FontAwesomeIcons.book,
        label: 'Al Hadith',
        onTap: () => Navigator.of(context).pushNamed(
          FeatureDetailScreen.routeName,
          arguments: const FeatureDetailArgs('hadith'),
        ),
      ),
      _HomeFeature(
        icon: FontAwesomeIcons.heartPulse,
        label: 'Asma Ul Husna',
        onTap: () => Navigator.of(context).pushNamed(
          FeatureDetailScreen.routeName,
          arguments: const FeatureDetailArgs('asma'),
        ),
      ),
      _HomeFeature(
        icon: Icons.repeat,
        label: 'Tasbih',
        onTap: () => Navigator.of(context).pushNamed(
          FeatureDetailScreen.routeName,
          arguments: const FeatureDetailArgs('tasbih'),
        ),
      ),
      _HomeFeature(
        icon: FontAwesomeIcons.compass,
        label: 'Qibla Compass',
        onTap: () => Navigator.of(context).pushNamed(
          FeatureDetailScreen.routeName,
          arguments: const FeatureDetailArgs('qibla'),
        ),
      ),
      _HomeFeature(
        icon: FontAwesomeIcons.moon,
        label: 'Siyam Timing',
        onTap: () => Navigator.of(context).pushNamed(
          FeatureDetailScreen.routeName,
          arguments: const FeatureDetailArgs('siyam'),
        ),
      ),
      _HomeFeature(
        icon: FontAwesomeIcons.handsPraying,
        label: 'Dua for Everyday',
        onTap: () => Navigator.of(context).pushNamed(
          FeatureDetailScreen.routeName,
          arguments: const FeatureDetailArgs('dua'),
        ),
      ),
      _HomeFeature(
        icon: FontAwesomeIcons.kaaba,
        label: 'Hajj & Umrah',
        onTap: () => Navigator.of(context).pushNamed(
          FeatureDetailScreen.routeName,
          arguments: const FeatureDetailArgs('hajj'),
        ),
      ),
    ];

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 360,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(32),
                            bottomRight: Radius.circular(32),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF2FC07F), Color(0xFF68E3A6)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 110,
                        left: 0,
                        right: 0,
                        child: Opacity(
                          opacity: 0.1,
                          child: Image.asset(
                            'assets/images/mosque_silhouette.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '09 Muharram, 1444',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Bismillah ir-Rahman ir-Rahim',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .pushNamed(PrayerTimesScreen.routeName),
                              child: AnimatedBuilder(
                                animation: locator<PrayerLocationStore>(),
                                builder: (context, _) {
                                  final store = locator<PrayerLocationStore>();
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          store.city,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 120,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: const [
                            Text(
                              'FAJR',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '4 hours to Zuhr',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white70, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            _PrayerTimeItem(
                              label: 'Fajr',
                              icon: FontAwesomeIcons.cloudSun,
                              time: '04:41',
                            ),
                            _PrayerTimeItem(
                              label: 'Dhuhr',
                              icon: FontAwesomeIcons.solidSun,
                              time: '12:00',
                            ),
                            _PrayerTimeItem(
                              label: 'Asr',
                              icon: FontAwesomeIcons.cloudSun,
                              time: '15:14',
                            ),
                            _PrayerTimeItem(
                              icon: FontAwesomeIcons.cloudMoon,
                              label: 'Maghrib',
                              time: '18:02',
                            ),
                            _PrayerTimeItem(
                              icon: FontAwesomeIcons.moon,
                              label: 'Isha',
                              time: '19:11',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GlassContainer(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 16,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GridView.count(
                            crossAxisCount: 3,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.88,
                            children: [
                              for (final feature in features)
                                _FeatureItem(
                                  icon: feature.icon,
                                  label: feature.label,
                                  onTap: feature.onTap,
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2FC07F),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PrayerTimeItem extends StatelessWidget {
  final IconData icon;
  final String label, time;
  const _PrayerTimeItem({
    required this.icon,
    required this.label,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        const SizedBox(height: 4),
        Icon(icon, size: 24, color: Colors.white),
        const SizedBox(height: 2),
        Text(time, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FeatureItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFE8FAF1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: const Color(0xFF2FC07F), size: 24),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeFeature {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HomeFeature({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}
