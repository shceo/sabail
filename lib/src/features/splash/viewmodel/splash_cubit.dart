import 'package:bloc/bloc.dart';

/// SplashCubit хранит состояние: true — показываем сплэш, false — показываем App
class SplashCubit extends Cubit<bool> {
  SplashCubit() : super(true) {
    _init();
  }

  Future<void> _init() async {
    // Задержка 5 секунд (как вам нужно)
    await Future.delayed(const Duration(seconds: 5));
    emit(false);
  }
}
