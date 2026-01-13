import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabail/src/core/widgets/glass_container.dart';
import 'package:sabail/src/features/profile/presentation/viewmodels/profile_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileViewModel viewModel = ProfileViewModel();

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
                      children: const [
                        Text(
                          'Профиль',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.more_horiz, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _HeaderCard(viewModel: viewModel),
                    const SizedBox(height: 16),
                    _StatsRow(viewModel: viewModel),
                    const SizedBox(height: 16),
                    _SettingsCard(viewModel: viewModel),
                    const SizedBox(height: 16),
                    _ActionsCard(),
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

class _HeaderCard extends StatelessWidget {
  final ProfileViewModel viewModel;
  const _HeaderCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(24),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Colors.white24, Colors.white10],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.white30),
            ),
            child: const Center(
              child: Icon(Icons.person, color: Colors.white, size: 30),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 16, color: Colors.white70),
                    const SizedBox(width: 4),
                    Text(
                      viewModel.city,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Text(
                'Подряд',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                '${viewModel.streak} дн.',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final ProfileViewModel viewModel;
  const _StatsRow({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GlassContainer(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
            child: Column(
              children: [
                const Text(
                  'Пожертвования',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  '${viewModel.donated.toStringAsFixed(2)} \$',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GlassContainer(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
            child: Column(
              children: const [
                Text(
                  'Награды',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      '3 активны',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final ProfileViewModel viewModel;
  const _SettingsCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Column(
        children: [
          _SwitchRow(
            label: 'Уведомления',
            value: viewModel.notificationsEnabled,
            onChanged: viewModel.toggleNotifications,
          ),
          const Divider(color: Colors.white12, height: 1),
          _SwitchRow(
            label: 'Локация для намаза',
            value: viewModel.locationEnabled,
            onChanged: viewModel.toggleLocation,
          ),
        ],
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _SwitchRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          const Spacer(),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: Colors.white24,
          ),
        ],
      ),
    );
  }
}

class _ActionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Column(
        children: [
          _ActionRow(
            icon: FontAwesomeIcons.solidPenToSquare,
            label: 'Редактировать профиль',
          ),
          const Divider(color: Colors.white12, height: 1),
          _ActionRow(
            icon: FontAwesomeIcons.clockRotateLeft,
            label: 'История пожертвований',
          ),
          const Divider(color: Colors.white12, height: 1),
          _ActionRow(
            icon: FontAwesomeIcons.shieldHalved,
            label: 'Конфиденциальность',
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ActionRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          FaIcon(icon, color: Colors.white70, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white70),
        ],
      ),
    );
  }
}
