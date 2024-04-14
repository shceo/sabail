import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sabail/ui/theme/app_colors.dart';

class MainWidgets extends StatelessWidget {
  const MainWidgets({Key? key});

  @override
  Widget build(BuildContext context) {
    List<String> texts = ['99 имен Аллаха', 'Хадисы', 'Дуа'];
    List<IconData> icons = [
      FlutterIslamicIcons.allah,
      FlutterIslamicIcons.solidMohammad,
      FlutterIslamicIcons.prayer
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
            width: 90,
            height: 90,
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
                  style: TextStyle(color: Colors.black, fontSize: 12),
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
          title: const Text('99 имен Аллаха'),
        ),
        body: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/json/namesofAllah.json'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitCircle(color: SabailColors.lightpurple),
                    const SizedBox(height: 20),
                    const Text('Загружаюсь...'),
                  ],
                ),
              );
            }
            var data = json.decode(snapshot.data.toString());
            List<dynamic> names = data['data'];
            return ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                var name = names[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal:
                              16), // Добавляем отступы по вертикали и горизонтали
                      leading: CircleAvatar(
                        backgroundColor: SabailColors.darkpurple,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        name['en']['meaning'],
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              name['name'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            name['ru']['meaning'],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(indent: 65), // Линии начинаются после нумерации
                  ],
                );
              },
            );
          },
        ),
      );
    } else if (index == 1) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Хадисы'),
        ),
        body: Center(
          child: Text('Здесь будут отображаться Хадисы'),
        ),
      );
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
