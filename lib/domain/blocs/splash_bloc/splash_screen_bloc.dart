import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashBloc() : super(SplashScreenInitial()) {
    on<AppStarted>((event, emit) async {
      await Future.delayed(const Duration(seconds: 8));
      emit(AppLoaded());
    });
  }
}
