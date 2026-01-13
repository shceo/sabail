import 'package:flutter/material.dart';
import 'package:sabail/src/core/di/locator.dart';
import 'package:sabail/src/core/widgets/glass_container.dart';
import 'package:sabail/src/core/widgets/shimmer_box.dart';
import 'package:sabail/src/features/prayer_times/data/prayer_times_repository.dart';
import 'package:sabail/src/features/prayer_times/presentation/viewmodels/prayer_location_store.dart';
import 'package:sabail/src/features/prayer_times/presentation/viewmodels/prayer_times_viewmodel.dart';
import 'package:sabail/src/core/services/city_service.dart';
import 'package:sabail/src/core/services/location_service.dart';
import 'package:sabail/src/core/notifications/notification_service.dart';

class PrayerTimesScreen extends StatefulWidget {
  static const String routeName = '/prayer_times';
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  late final PrayerTimesViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = PrayerTimesViewModel(
      repository: locator<PrayerTimesRepository>(),
      cityService: locator<CityService>(),
      locationService: locator<LocationService>(),
      notificationService: locator<NotificationService>(),
      locationStore: locator<PrayerLocationStore>(),
    )..init();
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
                              'AlAdhan API + оффлайн кеш',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          onPressed: () => viewModel.loadForCity(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _LocationCard(viewModel: viewModel),
                    const SizedBox(height: 16),
                    _NextPrayerCard(viewModel: viewModel),
                    const SizedBox(height: 16),
                    _ScheduleCard(viewModel: viewModel),
                    const SizedBox(height: 16),
                    _InfoCard(),
                    if (viewModel.error != null) ...[
                      const SizedBox(height: 12),
                      _ErrorCard(error: viewModel.error!),
                    ]
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

class _LocationCard extends StatelessWidget {
  final PrayerTimesViewModel viewModel;
  const _LocationCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final isLoading = viewModel.isLoadingCities;
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.location_on_outlined,
                    color: Colors.white),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Город и страна',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: isLoading ? null : viewModel.useCurrentLocation,
                child: const Text(
                  'Моя геолокация',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          isLoading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerBox(height: 44),
                    SizedBox(height: 12),
                    ShimmerBox(height: 44),
                  ],
                )
              : Column(
                  children: [
                    _Dropdown(
                      label: 'Страна',
                      value: viewModel.country,
                      options: viewModel.countries,
                      onChanged: (value) async {
                        if (value != null) {
                          await viewModel.loadCities(value);
                          await viewModel.loadForCity();
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    _Dropdown(
                      label: 'Город',
                      value: viewModel.city,
                      options: viewModel.cities,
                      onChanged: (value) {
                        if (value != null) {
                          viewModel.selectCity(value);
                        }
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  const _Dropdown({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white24),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: options.contains(value) ? value : null,
          hint: Text(
            label,
            style: const TextStyle(color: Colors.white70),
          ),
          dropdownColor: const Color(0xFF0F5D46),
          iconEnabledColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          items: options
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: onChanged,
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
    final label =
        viewModel.nextPrayerLabel() ?? 'Все молитвы за день завершены';
    final timeLeft = viewModel.timeUntilNextPrayer();
    final isLoading = viewModel.isLoading || viewModel.day == null;

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
              color: Colors.white.withValues(alpha: 0.16),
            ),
            child: const Icon(Icons.mosque, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: isLoading
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      ShimmerBox(height: 18, width: 120),
                      SizedBox(height: 8),
                      ShimmerBox(height: 16, width: 180),
                    ],
                  )
                : Column(
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
    final isLoading = viewModel.isLoading || viewModel.day == null;

    Widget content;
    if (isLoading) {
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          ShimmerBox(height: 18, width: 100),
          SizedBox(height: 12),
          ShimmerBox(height: 16, width: 220),
          SizedBox(height: 10),
          ShimmerBox(height: 16, width: 240),
          SizedBox(height: 10),
          ShimmerBox(height: 16, width: 200),
          SizedBox(height: 10),
          ShimmerBox(height: 16, width: 230),
          SizedBox(height: 10),
          ShimmerBox(height: 16, width: 180),
        ],
      );
    } else {
      final date = viewModel.day!.date;
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Расписание на сегодня',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}',
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
      );
    }

    return GlassContainer(child: content);
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
          Icon(Icons.volume_up, color: Colors.white70),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Уведомления с азаном активируются для всех молитв. Можно менять город вручную или через геолокацию.',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String error;
  const _ErrorCard({required this.error});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      tint: Colors.red,
      opacity: 0.18,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              error,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
