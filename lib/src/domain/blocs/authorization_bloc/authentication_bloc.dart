
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabail/src/domain/api/users.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<RegisterEvent>(_registerPageEvent);
    on<AuthEvent>(_authPageEvent);  
    on<SignOutEvent>(_signOutEvent);
  }

  
Future<void> _registerPageEvent(RegisterEvent event, Emitter<AuthenticationState> emit) async {
  if (event.email.isEmpty || event.password.isEmpty || event.firstName.isEmpty || event.lastName.isEmpty) {
    emit(AuthErrorState('Все поля должны быть заполнены.'));
    return;
  }

  try {
    // Здесь можно добавить логику регистрации пользователя через FirebaseAuth
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );

    emit(RegistrationState());
  } catch (e) {
    emit(AuthErrorState(e.toString()));
  }
}
  
  // Future<void> _registerPageEvent(RegisterEvent event, Emitter<AuthenticationState> emit) async{
  //   emit(RegistrationState());
  // }
  
  Future<void> _authPageEvent (
    AuthEvent event, Emitter<AuthenticationState> emit) async {
      emit(AuthState());
    }
    
      Future<void> _signOutEvent (
    SignOutEvent event, Emitter<AuthenticationState> emit) async {
      FirebaseAuth.instance.signOut();
      emit(AuthState());
}


}