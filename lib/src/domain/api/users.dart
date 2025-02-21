import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Users {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confrimPasswordsController = TextEditingController();

  // регистрация
  Future signUp() async {
    if (passwordsConfirm() &&
        emailController.text.trim() != '' &&
        passwordController.text.trim() != '') {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
  }
  
  // проверка пароля 
  bool passwordsConfirm() {
    if ( passwordController.text.trim() ==  confrimPasswordsController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }
  
  
  // авторизация 
  
  Future signIn() async {
    if (emailController.text.trim() == '' && passwordController.text.trim() == '') {
      return;
    } else {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
    }
  }
}
