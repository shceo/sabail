import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:sabail/ui/pages/Sadaqa_project.dart';
import 'package:sabail/ui/pages/profilepage.dart';
import 'package:sabail/ui/pages/settings_page.dart';
import 'package:sabail/ui/theme/app_colors.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SabailColors.notwhite,
      body: const ProfileBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(height: 50),
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundColor: SabailColors.lightpurple,
            child: const Text(
              "JC",
              style: TextStyle(fontSize: 40.0, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Center(
            child: Text("Jane Cooper",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
        const Center(
            child: Text("arafatux@gmail.com", style: TextStyle(fontSize: 16))),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: SabailColors.lightpurple.withOpacity(0.6),
            ),
            child: const ListTile(
              leading: Icon(Icons.group_add),
              title: Text('Профиль'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: SabailColors.lightpurple.withOpacity(0.6),
            ),
            child: const ListTile(
              leading: Icon(FlutterIslamicIcons.solidZakat),
              title: Text('Фонд "Sadaqa"'),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => SadaqaProj())));
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: SabailColors.lightpurple.withOpacity(0.6),
            ),
            child: const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Настройки'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (((context) => SettingsPage())),
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: SabailColors.lightpurple.withOpacity(0.6),
            ),
            child: const ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('Условия использования'),
            ),
            onPressed: () {/* FAQs */},
          ),
        ),
      ],
    );
  }
}
