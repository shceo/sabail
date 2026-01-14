import 'package:flutter/material.dart';
import 'package:sabail/src/core/widgets/glass_container.dart';

class DonationHistoryScreen extends StatelessWidget {
  static const String routeName = '/profile/donations';
  const DonationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final donations = <_DonationItem>[
      _DonationItem('Zakat', 120.00, '12 Jan 2026'),
      _DonationItem('Sadaqah', 30.00, '07 Jan 2026'),
      _DonationItem('Masjid Fund', 75.50, '02 Jan 2026'),
      _DonationItem('Orphan Support', 50.00, '28 Dec 2025'),
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
                      'Donation History',
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
                padding: const EdgeInsets.all(18),
                borderRadius: BorderRadius.circular(24),
                child: Row(
                  children: [
                    const Icon(Icons.favorite_outline, color: Colors.white70),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Total donated this month',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const Text(
                      '\$275.50',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              for (final donation in donations) ...[
                GlassContainer(
                  padding: const EdgeInsets.all(16),
                  borderRadius: BorderRadius.circular(20),
                  child: Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.volunteer_activism_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              donation.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              donation.date,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '\$${donation.amount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DonationItem {
  final String title;
  final double amount;
  final String date;

  const _DonationItem(this.title, this.amount, this.date);
}
