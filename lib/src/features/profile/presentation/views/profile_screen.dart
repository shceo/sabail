import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sabail/src/core/widgets/glass_container.dart';
import 'package:sabail/src/features/profile/presentation/views/donation_history_screen.dart';
import 'package:sabail/src/features/profile/presentation/views/edit_profile_screen.dart';
import 'package:sabail/src/features/profile/presentation/views/privacy_screen.dart';
import 'package:sabail/src/features/profile/presentation/viewmodels/profile_viewmodel.dart';
import 'package:sabail/src/features/settings/presentation/views/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({super.key});

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
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings, color: Colors.white),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(SettingsScreen.routeName),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _HeaderCard(viewModel: viewModel),
                    const SizedBox(height: 16),
                    _StatsRow(viewModel: viewModel),
                    const SizedBox(height: 16),
                    _SettingsShortcutCard(
                      onTap: () => Navigator.of(context)
                          .pushNamed(SettingsScreen.routeName),
                    ),
                    const SizedBox(height: 16),
                    _ActionsCard(
                      onEditProfile: () => Navigator.of(context)
                          .pushNamed(EditProfileScreen.routeName),
                      onDonationHistory: () => Navigator.of(context)
                          .pushNamed(DonationHistoryScreen.routeName),
                      onPrivacy: () => Navigator.of(context)
                          .pushNamed(PrivacyScreen.routeName),
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
                'Streak',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                '${viewModel.streak} days',
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
                  'Donated',
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
                  'Badges',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      '3 completed',
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

class _SettingsShortcutCard extends StatelessWidget {
  final VoidCallback onTap;
  const _SettingsShortcutCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: _ActionRow(
        icon: Icons.tune,
        label: 'Settings & Notifications',
        onTap: onTap,
      ),
    );
  }
}

class _ActionsCard extends StatelessWidget {
  final VoidCallback onEditProfile;
  final VoidCallback onDonationHistory;
  final VoidCallback onPrivacy;

  const _ActionsCard({
    required this.onEditProfile,
    required this.onDonationHistory,
    required this.onPrivacy,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Column(
        children: [
          _ActionRow(
            icon: FontAwesomeIcons.solidPenToSquare,
            label: 'Edit profile',
            onTap: onEditProfile,
          ),
          const Divider(color: Colors.white12, height: 1),
          _ActionRow(
            icon: FontAwesomeIcons.clockRotateLeft,
            label: 'Donation history',
            onTap: onDonationHistory,
          ),
          const Divider(color: Colors.white12, height: 1),
          _ActionRow(
            icon: FontAwesomeIcons.shieldHalved,
            label: 'Privacy & security',
            onTap: onPrivacy,
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ActionRow({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
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
        ),
      ),
    );
  }
}
