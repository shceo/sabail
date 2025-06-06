import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:sabail/src/presentation/features/auth/view/login_page.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Личный кабинет',
          style: GoogleFonts.oswald(fontSize: 25),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: const Icon(FlutterIslamicIcons.mosque),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF9F9F9),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildProfileHeader(context, user),
              const SizedBox(height: 30),
              _buildAccountSection(context),
              const SizedBox(height: 15),
              _buildSectionHeader('Поддержка и помощь'),
              const SizedBox(height: 15),
              _buildHelpSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, User? user) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.green, Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(FlutterIslamicIcons.family, color: Colors.white, size: 32),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.displayName ?? 'Ваше имя не указано',
                  style: GoogleFonts.oswald(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? 'Ваш email не указан',
                  style: GoogleFonts.oswald(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(
                FlutterIslamicIcons.quran,
                color: Colors.white,
              ),
              onPressed: () {
                // Навигация в редактирование профиля (можно добавить страницу)
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccountSection(BuildContext context) {
    return _buildCard([
      _buildListTile(
        context,
        title: 'Настройки профиля',
        subtitle: 'Редактировать данные аккаунта',
        leadingIcon: FlutterIslamicIcons.prayer,
        onTap: () {
          // Добавить логику редактирования профиля
        },
      ),
      const Divider(),
      _buildListTile(
        context,
        title: 'Личные данные',
        subtitle: 'Имя, интересы и информация',
        leadingIcon: FlutterIslamicIcons.quran,
        onTap: () {
          // Добавить логику
        },
      ),
      const Divider(),
      _buildListTile(
        context,
        title: 'Выход из приложения',
        subtitle: 'Завершить сеанс',
        leadingIcon: FlutterIslamicIcons.islam,
        onTap: () => {},
      ),
    ]);
  }

  Widget _buildHelpSection(BuildContext context) {
    return _buildCard([
      _buildListTile(
        context,
        title: 'Центр поддержки',
        subtitle: 'Вопросы и советы',
        leadingIcon: FlutterIslamicIcons.solidTakbir,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HelpSupportPage()),
          );
        },
      ),
      const Divider(),
      _buildListTile(
        context,
        title: 'О приложении',
        subtitle: 'Информация о приложении',
        leadingIcon: FlutterIslamicIcons.kaaba,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AboutAppPage()),
          );
        },
      ),
    ]);
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: GoogleFonts.oswald(
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFFFFFFF),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required String title,
    String? subtitle,
    required IconData leadingIcon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(leadingIcon, color: Colors.green),
      title: Text(
        title,
        style: GoogleFonts.oswald(textStyle: const TextStyle(fontSize: 16)),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: GoogleFonts.oswald(textStyle: const TextStyle(fontSize: 14, color: Colors.grey)),
            )
          : null,
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // Обязательно с микротаской или delayed, чтобы избежать Navigator conflict
    Future.microtask(() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    });
  }
}

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Центр поддержки')));
  }
}

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('О приложении')));
  }
}
