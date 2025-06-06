import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';

class TimeCubit extends Cubit<String> {
  TimeCubit() : super(DateFormat.Hms().format(DateTime.now())) {
    _update();
  }

  void _update() {
    Future.delayed(const Duration(seconds: 1), () {
      emit(DateFormat.Hms().format(DateTime.now()));
      _update();
    });
  }
}
