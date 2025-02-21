part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

class RegistrationState extends AuthenticationState {
  final user = Users();

  Future signUpUser() async {
    user.signUp();
  }
}

class AuthState extends AuthenticationState {
   final user = Users();
   
   Future signInUser() async {
    user.signIn();
  }
}

class SignedState extends AuthenticationState {}

class AuthErrorState extends AuthenticationState {
  final String message;

  AuthErrorState(this.message);
}
