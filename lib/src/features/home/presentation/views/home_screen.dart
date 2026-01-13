// File: lib/src/features/home/presentation/views/home_screen.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          // 1) Hero-секция с зелёным градиентом и скруглением по низу
          SizedBox(
            height: 360,
            width: double.infinity,
            child: Stack(
              children: [
                ClipRRect(
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
                Positioned(
                  top: 110,
                  left: 0,
                  // bottom: 0,
                  right: 0,
                  child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      'assets/images/mosque_silhouette.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '09 Muharram, 1444',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Sylhet',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                        style: TextStyle(color: Colors.white70, fontSize: 16),
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

          // 2) Нижняя панель с иконками (сжатая)
          // Вместо Expanded(...) теперь:
          Flexible(
            fit: FlexFit.loose,
            child: Transform.translate(
              offset: const Offset(0, -12),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      spacing: (w - 32 - 4 * 80) / 2, // 3 колонки
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: const [
                        _FeatureItem(
                          icon: FontAwesomeIcons.handPointUp,
                          label: 'Kalma',
                        ),
                        _FeatureItem(
                          icon: FontAwesomeIcons.bookQuran,
                          label: 'Al Qur’an',
                        ),
                        _FeatureItem(
                          icon: FontAwesomeIcons.book,
                          label: 'Al Hadith',
                        ),
                        _FeatureItem(
                          icon: FontAwesomeIcons.heartbeat,
                          label: 'Asma Ul Husna',
                        ),
                        _FeatureItem(icon: Icons.repeat, label: 'Tasbih'),
                        _FeatureItem(
                          icon: FontAwesomeIcons.compass,
                          label: 'Qibla Compass',
                        ),
                        _FeatureItem(
                          icon: FontAwesomeIcons.moon,
                          label: 'Siyam Timing',
                        ),
                        _FeatureItem(
                          icon: FontAwesomeIcons.handsPraying,
                          label: 'Dua for everyday',
                        ),
                        _FeatureItem(
                          icon: FontAwesomeIcons.kaaba,
                          label: 'Hajj & Umrah',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Индикация страниц
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
  const _FeatureItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
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
    );
  }
}
