import 'package:bloc/bloc.dart';
import '../../../../domain/entities/city.dart';
import '../../../../domain/usecases/get_city_usecase.dart';

class ProfileState {
  final City? city;
  final bool isLoading;
  final String? error;

  const ProfileState({this.city, this.isLoading = false, this.error});

  ProfileState copyWith({City? city, bool? isLoading, String? error}) {
    return ProfileState(
      city: city ?? this.city,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class ProfileCubit extends Cubit<ProfileState> {
  final GetCityUseCase _getCity;
  ProfileCubit({required GetCityUseCase getCity})
    : _getCity = getCity,
      super(const ProfileState());

  Future<void> loadCity() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final c = await _getCity.execute();
      emit(state.copyWith(city: c, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
