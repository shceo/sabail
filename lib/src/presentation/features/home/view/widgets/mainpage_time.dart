import 'package:flutter/material.dart';

class CurrentTimeWidget extends StatelessWidget {
  const CurrentTimeWidget({super.key, required this.time});

  final String time;

  @override
  Widget build(BuildContext context) {
    final timeParts = time.split(':');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${timeParts[0]}:${timeParts[1]}',
          style: const TextStyle(fontSize: 65, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(
          timeParts[2],
          style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
      ],
    );
  }
}
