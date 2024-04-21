import 'package:flutter/material.dart';

class SadaqaProj extends StatelessWidget {
  const SadaqaProj({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sadaqa Project',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: SadaqaProjBody(),
    );
  }
}

class SadaqaProjBody extends StatelessWidget {
  const SadaqaProjBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ImageNotifier imageNotifier = ImageNotifier();

    return SingleChildScrollView(
      child: Column(
        children: [
        ]
      ),
    );
  }
}
