import 'package:flutter/material.dart';
import 'package:sabail/src/core/widgets/glass_container.dart';

class PrivacyScreen extends StatefulWidget {
  static const String routeName = '/profile/privacy';
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool shareActivity = false;
  bool shareDonations = true;
  bool showOnlineStatus = true;

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
                  const Expanded(
                    child: Text(
                      'Privacy',
                      style: TextStyle(
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
                padding: const EdgeInsets.all(16),
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  children: [
                    _ToggleRow(
                      label: 'Share activity with friends',
                      value: shareActivity,
                      onChanged: (value) =>
                          setState(() => shareActivity = value),
                    ),
                    const Divider(color: Colors.white12, height: 16),
                    _ToggleRow(
                      label: 'Show donation amounts',
                      value: shareDonations,
                      onChanged: (value) =>
                          setState(() => shareDonations = value),
                    ),
                    const Divider(color: Colors.white12, height: 16),
                    _ToggleRow(
                      label: 'Show online status',
                      value: showOnlineStatus,
                      onChanged: (value) =>
                          setState(() => showOnlineStatus = value),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GlassContainer(
                padding: const EdgeInsets.all(16),
                borderRadius: BorderRadius.circular(20),
                child: Row(
                  children: const [
                    Icon(Icons.lock_outline, color: Colors.white70),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your data stays on device unless you export it.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          thumbColor: const WidgetStatePropertyAll(Colors.white),
          trackColor: const WidgetStatePropertyAll(Colors.white24),
        ),
      ],
    );
  }
}
