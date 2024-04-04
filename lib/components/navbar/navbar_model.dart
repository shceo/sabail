
import 'package:flutter/material.dart';

class NavigationTabItem extends StatelessWidget {
  const NavigationTabItem({
    super.key,
    required this.icon,
    required this.text,
    required this.active,
  });

  final String text;
  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(top: 14),
      child: Column(
        children: [
          Icon(
            icon,
            color: active ? Colors.purple : Colors.grey.withOpacity(0.7),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 10, color: active ? Colors.purple[700] : Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
