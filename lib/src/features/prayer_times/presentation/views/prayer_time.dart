import 'package:flutter/material.dart';
import 'package:sabail/src/core/di/locator.dart';
import 'package:sabail/src/core/widgets/glass_container.dart';
import 'package:sabail/src/features/prayer_times/data/prayer_times_repository.dart';
import 'package:sabail/src/features/prayer_times/presentation/viewmodels/prayer_times_viewmodel.dart';

class PrayerTimesScreen extends StatefulWidget {
  static const String routeName = '/prayer_times';
  const PrayerTimesScreen({Key? key}) : super(key: key);

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  late final PrayerTimesViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = PrayerTimesViewModel(locator<PrayerTimesRepository>())
      ..loadForDate(DateTime.now());
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

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
                if (viewModel.error != null) {
                  return Center(
                    child: GlassContainer(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.error_outline,
                              color: Colors.white, size: 32),
                          const SizedBox(height: 8),
                          Text(
                            'Не удалось загрузить время\n${viewModel.error}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () =>
                                viewModel.loadForDate(DateTime.now()),
                            child: const Text(
                              'Повторить',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Время молитв',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Сегодня',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          onPressed: () =>
                              viewModel.loadForDate(DateTime.now()),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _NextPrayerCard(viewModel: viewModel),
                    const SizedBox(height: 16),
                    _ScheduleCard(viewModel: viewModel),
                    const SizedBox(height: 16),
                    _InfoCard(),
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

class _NextPrayerCard extends StatelessWidget {
  final PrayerTimesViewModel viewModel;
  const _NextPrayerCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final label = viewModel.nextPrayerLabel() ?? 'Все молитвы прочитаны';
    final timeLeft = viewModel.timeUntilNextPrayer();

    return GlassContainer(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.16),
            ),
            child: const Icon(Icons.mosque, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Следующая молитва',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (timeLeft != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Через $timeLeft',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Icon(Icons.arrow_forward, color: Colors.white),
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  final PrayerTimesViewModel viewModel;
  const _ScheduleCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoading || viewModel.day == null) {
      return GlassContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.2,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12),
            Text(
              'Обновляем расписание...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    }

    return GlassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Расписание',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${viewModel.day!.date.day.toString().padLeft(2, '0')}.${viewModel.day!.date.month.toString().padLeft(2, '0')}',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _PrayerRow(
            label: 'Fajr',
            time: viewModel.formatted(viewModel.timeOf('fajr')),
            icon: Icons.wb_twilight,
          ),
          _PrayerRow(
            label: 'Dhuhr',
            time: viewModel.formatted(viewModel.timeOf('dhuhr')),
            icon: Icons.wb_sunny_rounded,
          ),
          _PrayerRow(
            label: 'Asr',
            time: viewModel.formatted(viewModel.timeOf('asr')),
            icon: Icons.cloud_queue,
          ),
          _PrayerRow(
            label: 'Maghrib',
            time: viewModel.formatted(viewModel.timeOf('maghrib')),
            icon: Icons.nights_stay_outlined,
          ),
          _PrayerRow(
            label: 'Isha',
            time: viewModel.formatted(viewModel.timeOf('isha')),
            icon: Icons.brightness_3_outlined,
          ),
        ],
      ),
    );
  }
}

class _PrayerRow extends StatelessWidget {
  final String label;
  final String time;
  final IconData icon;

  const _PrayerRow({
    required this.label,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(18),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: const [
          Icon(Icons.location_on_outlined, color: Colors.white70),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Автообновление по вашей локации и кеш в оффлайне.',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
