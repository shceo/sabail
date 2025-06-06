import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  final String? errorMessage;
  const AuthState({this.errorMessage});

  AuthState copyWith({String? errorMessage}) {
    return AuthState(errorMessage: errorMessage);
  }
}

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth;
  AuthCubit({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance,
      super(const AuthState());

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    if (email.isEmpty ||
        password.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty) {
      emit(state.copyWith(errorMessage: 'Все поля должны быть заполнены.'));
      return;
    }
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _auth.currentUser?.updateDisplayName('$firstName $lastName');
      emit(const AuthState());
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(const AuthState());
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
