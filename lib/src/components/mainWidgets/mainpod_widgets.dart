import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:sabail/src/ui/pages/sadaqa_project.dart';
import 'package:sabail/src/ui/theme/app_colors.dart';

class MainPodWidgets extends StatelessWidget {
  const MainPodWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> texts = ['Викторина', 'صدقة', 'Календарь'];
    List<IconData> icons = [
      FlutterIslamicIcons.solidLantern,
      FlutterIslamicIcons.solidZakat,
      FlutterIslamicIcons.calendar
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        3,
        (index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Page(index)),
            );
          },
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icons[index],
                  size: 28,
                  color: SabailColors.darkpurple,
                ),
                Text(
                  texts[index],
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  // новый класс для страницы, на которую будет осуществлен переход
  final int index;
  Page(this.index);

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text('99 имен Аллаха'),
        ),
        body: Center(
          child: Text('Здесь будут отображаться 99 имен Аллаха'),
        ),
      );
    } else if (index == 1) {
      return const SadaqaProj();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Дуа'),
        ),
        body: Center(
          child: Text('Здесь будут отображаться Дуа'),
        ),
      );
    }
  }
}
