import 'package:bloc/bloc.dart';

class SplashState {
  final bool loaded;
  const SplashState({this.loaded = false});

  SplashState copyWith({bool? loaded}) {
    return SplashState(loaded: loaded ?? this.loaded);
  }
}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 8));
    emit(state.copyWith(loaded: true));
  }
}
