import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabail/src/ui/theme/app_colors.dart';

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
    final myWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Container(
          width: myWidth,
          height: 88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: SabailColors.lightpurple,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.43),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 34,
        ),
        Text(
          'Скоро...',
          style: TextStyle(
            fontSize: 26,
            fontFamily: GoogleFonts.oswald().fontFamily,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: myWidth,
          height: 88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: SabailColors.lightpurple,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.43),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 44,
        ),
        Container(
          width: myWidth,
          height: 88,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: SabailColors.lightpurple,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.43),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
