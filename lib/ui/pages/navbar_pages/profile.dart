import 'package:flutter/material.dart';
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
        const Center(
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Text(
              "JC",
              style: TextStyle(fontSize: 40.0),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Center(child: Text("Jane Cooper", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
        const Center(child: Text("arafatux@gmail.com", style: TextStyle(fontSize: 16))),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
            ),
            child: const ListTile(
              leading: Icon(Icons.group_add),
              title: Text('Invite Friends'),
            ),
            onPressed: () {/* Invite friends */},
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
            ),
            child: const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Account Settings'),
            ),
            onPressed: () {/* Account settings */},
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
            ),
            child: const ListTile(
              leading: Icon(Icons.payment),
              title: Text('Billing'),
            ),
            onPressed: () {/* Billing */},
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
            ),
            child: const ListTile(
              leading: Icon(Icons.language),
              title: Text('Change Language'),
            ),
            onPressed: () {/* Change language */},
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
            ),
            child: const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            onPressed: () {/* Settings */},
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
            ),
            child: const ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('FAQs'),
            ),
            onPressed: () {/* FAQs */},
          ),
        ),
        // Добавленная кнопка
        Container(
          margin: const EdgeInsets.all(10),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[200],
            ),
            child: const ListTile(
              // leading: Icon(Icons.add),
              // title: Text('Additional Button'),
            ),
            onPressed: () {/* Additional button action */},
          ),
        ),
      ],
    );
  }
}
