import 'package:flutter/material.dart';

class EmptyBlocksRow extends StatelessWidget {
  const EmptyBlocksRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        3,
        (index) => Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}
