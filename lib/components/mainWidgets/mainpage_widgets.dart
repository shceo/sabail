import 'package:flutter/material.dart';

class MainWidgets extends StatelessWidget {
  const MainWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> texts = ['99 имен Аллаха', 'Хадисы', 'Дуа'];
    List<IconData> icons = [Icons.book, Icons.message, Icons.mic];
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
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icons[index]), // иконка
                Text(
                  texts[index],
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12), // уменьшенный размер текста
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
