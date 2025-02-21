
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sabail/src/ui/pages/login_page.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Профиль',
          style: GoogleFonts.oswald(),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFF9F9F9),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 33, 17, 255),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(Icons.arrow_back_ios),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.displayName ?? 'Имя не установлено',
                              style: GoogleFonts.oswald(
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user?.email ?? 'Почта не указана',
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
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           const ProfileEditscreen()),
                            // );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width,
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
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.arrow_back_ios),
                        title: Text(
                          'Об аккаунте',
                          style: GoogleFonts.oswald(
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                        subtitle: Text(
                          'Изменить данные об аккаунте',
                          style: GoogleFonts.oswald(
                            textStyle: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_back_ios),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const ProfileEditscreen()),
                          // );
                        },
                      ),
                      Divider(color: Colors.grey[300]),
                      ListTile(
                        leading: Icon(Icons.arrow_back_ios),
                        title: Text(
                          'Персональная информация',
                          style: GoogleFonts.oswald(
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                        subtitle: Text(
                          'Ваши данные, увлечения, интересы',
                          style: GoogleFonts.oswald(
                            textStyle: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_back_ios),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const PersonalInfoPage()),
                          // );
                        },
                      ),
                      Divider(color: Colors.grey[300]),
                      ListTile(
                        leading: Image.asset(
                          'assets/images/sunrise.jpg',
                          width: 24,
                          height: 24,
                        ),
                        title: Text(
                          'Выход',
                          style: GoogleFonts.oswald(
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                        subtitle: Text(
                          'Выйти из аккаунта',
                          style: GoogleFonts.oswald(
                            textStyle: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_back_ios),
                        onTap: () {
                          // Реализация выхода
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Помощь',
                      style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)
                          .merge(
                        GoogleFonts.oswald(),
                      ),
                    )),
                const SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width,
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
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.arrow_back_ios),
                        title: Text(
                          'Помощь & Поддержка',
                          style: GoogleFonts.oswald(
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_back_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HelpSupportPage()),
                          );
                        },
                      ),
                      Divider(color: Colors.grey[300]),
                      ListTile(
                        leading: Icon(Icons.arrow_back_ios),
                        title: Text(
                          'О приложении',
                          style: GoogleFonts.oswald(
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_back_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Помощь & Поддержка')));
  }
}

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('О приложении')));
  }
}

