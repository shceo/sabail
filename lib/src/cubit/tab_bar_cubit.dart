import 'package:bloc/bloc.dart';

class TabBarCubit extends Cubit<int> {
  TabBarCubit() : super(0);
  void setIndex(int index) => emit(index);
}
