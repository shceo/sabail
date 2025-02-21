import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sabail/src/domain/blocs/authorization_bloc/authentication_bloc.dart';
import 'package:sabail/src/sabail.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController  = TextEditingController();
  final TextEditingController emailController     = TextEditingController();
  final TextEditingController passwordController  = TextEditingController();
  
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
  Future<void> _registerUser(String email, String password, String firstName, String lastName) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      
      // Обновляем профиль пользователя с именем и фамилией
      await userCredential.user?.updateDisplayName('$firstName $lastName');
      
      showToast('Регистрация успешна');
      
      if (!mounted) return;
      // Откладываем навигацию до завершения текущего цикла построения виджетов
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Sabail()),
        );
      });
    } catch (e) {
      showToast('Ошибка регистрации: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Авторизация и Регистрация')),
      body: BlocProvider(
        create: (context) => AuthenticationBloc(),
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is SignedState) {
              showToast('Успешный вход');
              Navigator.pop(context);
            } else if (state is RegistrationState) {
              showToast('Регистрация успешна');
            } else if (state is AuthErrorState) {
              showToast(state.message);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'Имя',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Фамилия',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Почта',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Пароль',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                          showToast('Заполните все поля');
                        } else {
                          _registerUser(
                            emailController.text,
                            passwordController.text,
                            firstNameController.text,
                            lastNameController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Регистрация',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: const Text(
                          'Есть аккаунт? Войдите',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  
  final TextEditingController emailController    = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вход')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Пароль',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                  showToast('Заполните все поля');
                  return;
                }
                try {
                  final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text, password: passwordController.text);
                  if (user != null) {
                    showToast('Успешный вход');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Sabail()),
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    showToast('Пользователь не найден');
                  } else if (e.code == 'wrong-password') {
                    showToast('Неверный пароль');
                  } else {
                    showToast(e.message ?? 'Ошибка входа');
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'Войти',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Обновлённая функция показа тоста, отложенная до следующего кадра.
void showToast(String message) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  });
}