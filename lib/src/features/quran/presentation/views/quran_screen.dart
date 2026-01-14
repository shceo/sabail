import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabail/src/core/widgets/glass_container.dart';
import 'package:sabail/src/features/quran/presentation/viewmodels/quran_viewmodel.dart';
import 'package:sabail/src/features/quran/presentation/views/quran_tool_screen.dart';

class QuranScreen extends StatefulWidget {
  static const String routeName = '/quran';
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  final QuranViewModel viewModel = QuranViewModel();

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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: AnimatedBuilder(
              animation: viewModel,
              builder: (context, _) {
                return ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Quran',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.info_outline, color: Colors.white),
                          onPressed: () => Navigator.of(context).pushNamed(
                            QuranToolScreen.routeName,
                            arguments: const QuranToolArgs('about'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    GlassContainer(
                      borderRadius: BorderRadius.circular(24),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Quran data and translations',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Offline cache keeps your recent surahs, '
                            'bookmarks, and daily ayah ready to read.',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _GlassTile(
                      icon: FontAwesomeIcons.solidBookmark,
                      title: 'Bookmarks',
                      subtitle: 'Saved ayahs and notes',
                      trailing: 'Open',
                      onTap: () => Navigator.of(context).pushNamed(
                        QuranToolScreen.routeName,
                        arguments: const QuranToolArgs('bookmarks'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _GlassTile(
                      icon: FontAwesomeIcons.clock,
                      title: 'Reading plan',
                      subtitle: 'Stay on a daily schedule',
                      trailing: 'View',
                      onTap: () => Navigator.of(context).pushNamed(
                        QuranToolScreen.routeName,
                        arguments: const QuranToolArgs('plan'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _GlassTile(
                      icon: FontAwesomeIcons.wandSparkles,
                      title: 'Daily ayah',
                      subtitle: 'A short reflection every day',
                      trailing: 'Start',
                      onTap: () => Navigator.of(context).pushNamed(
                        QuranToolScreen.routeName,
                        arguments: const QuranToolArgs('daily'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String trailing;
  final VoidCallback onTap;

  const _GlassTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: FaIcon(icon, color: Colors.white, size: 18),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Text(
                trailing,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
