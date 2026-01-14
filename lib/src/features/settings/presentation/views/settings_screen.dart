import 'package:flutter/material.dart';
import 'package:sabail/src/core/widgets/glass_container.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool prayerAlertsEnabled = true;
  bool azanSoundEnabled = true;
  bool vibrationEnabled = true;
  bool locationEnabled = true;
  bool quietHoursEnabled = false;
  bool autoTheme = true;
  bool darkMode = false;
  String language = 'English';
  String calcMethod = 'Muslim World League';

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
                      'Settings',
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
              _Section(
                title: 'Notifications',
                children: [
                  _ToggleRow(
                    label: 'Enable notifications',
                    value: notificationsEnabled,
                    onChanged: (value) =>
                        setState(() => notificationsEnabled = value),
                  ),
                  _ToggleRow(
                    label: 'Prayer time alerts',
                    value: prayerAlertsEnabled,
                    onChanged: notificationsEnabled
                        ? (value) =>
                            setState(() => prayerAlertsEnabled = value)
                        : null,
                  ),
                  _ToggleRow(
                    label: 'Azan sound',
                    value: azanSoundEnabled,
                    onChanged: notificationsEnabled
                        ? (value) => setState(() => azanSoundEnabled = value)
                        : null,
                  ),
                  _ToggleRow(
                    label: 'Vibration',
                    value: vibrationEnabled,
                    onChanged: notificationsEnabled
                        ? (value) => setState(() => vibrationEnabled = value)
                        : null,
                  ),
                  _ToggleRow(
                    label: 'Quiet hours',
                    value: quietHoursEnabled,
                    onChanged: notificationsEnabled
                        ? (value) => setState(() => quietHoursEnabled = value)
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _Section(
                title: 'Prayer Times',
                children: [
                  _ValueRow(
                    label: 'Calculation method',
                    value: calcMethod,
                    onTap: () {
                      _showMessage('Method picker coming soon.');
                    },
                  ),
                  _ValueRow(
                    label: 'Madhab',
                    value: 'Shafi',
                    onTap: () {
                      _showMessage('Madhab picker coming soon.');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _Section(
                title: 'Location',
                children: [
                  _ToggleRow(
                    label: 'Use GPS location',
                    value: locationEnabled,
                    onChanged: (value) =>
                        setState(() => locationEnabled = value),
                  ),
                  _ValueRow(
                    label: 'City',
                    value: 'Auto-detect',
                    onTap: () {
                      _showMessage('City selection coming soon.');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _Section(
                title: 'Appearance',
                children: [
                  _ToggleRow(
                    label: 'Auto theme',
                    value: autoTheme,
                    onChanged: (value) => setState(() => autoTheme = value),
                  ),
                  _ToggleRow(
                    label: 'Dark mode',
                    value: darkMode,
                    onChanged: autoTheme
                        ? null
                        : (value) => setState(() => darkMode = value),
                  ),
                  _ValueRow(
                    label: 'Language',
                    value: language,
                    onTap: () {
                      _showMessage('Language picker coming soon.');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _Section(
                title: 'Data & Storage',
                children: [
                  _ValueRow(
                    label: 'Clear cached data',
                    value: '12 MB',
                    onTap: () => _showMessage('Cache cleared.'),
                  ),
                  _ValueRow(
                    label: 'Export settings',
                    value: 'JSON',
                    onTap: () => _showMessage('Export ready.'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(20),
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
          const SizedBox(height: 12),
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              const Divider(color: Colors.white12, height: 16),
          ],
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const _ToggleRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveOnChanged = onChanged;
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: effectiveOnChanged == null
                  ? Colors.white38
                  : Colors.white,
              fontSize: 15,
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: effectiveOnChanged,
          thumbColor: const WidgetStatePropertyAll(Colors.white),
          trackColor: WidgetStatePropertyAll(
            effectiveOnChanged == null ? Colors.white12 : Colors.white24,
          ),
        ),
      ],
    );
  }
}

class _ValueRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ValueRow({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Text(
              value,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, color: Colors.white54, size: 18),
          ],
        ),
      ),
    );
  }
}
