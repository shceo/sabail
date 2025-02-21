part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class RegisterEvent extends AuthenticationEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  RegisterEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}


class AuthEvent extends AuthenticationEvent {
  final String email;
  final String password;

  AuthEvent({
    required this.email,
    required this.password,
  });
}

class SignOutEvent extends AuthenticationEvent {}