import 'package:bloc/bloc.dart';
import '../../../../domain/api/api.dart';
import '../../../../domain/repositories/city_repository.dart';

class PrayerState {
  final bool isLoading;
  final String? errorMessage;
  final List<String> prayerTimes;
  final DateTime? sunrise;
  final DateTime? sunset;

  const PrayerState({
    this.isLoading = false,
    this.errorMessage,
    this.prayerTimes = const [],
    this.sunrise,
    this.sunset,
  });

  PrayerState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<String>? prayerTimes,
    DateTime? sunrise,
    DateTime? sunset,
  }) {
    return PrayerState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      prayerTimes: prayerTimes ?? this.prayerTimes,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }
}

class PrayerCubit extends Cubit<PrayerState> {
  final PrayerTimes _prayerApi;
  final CityRepository _cityRepo;
  PrayerCubit({
    required PrayerTimes prayerApi,
    required CityRepository cityRepo,
  }) : _prayerApi = prayerApi,
       _cityRepo = cityRepo,
       super(const PrayerState());

  Future<void> loadAllData() async {
    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        prayerTimes: [],
        sunrise: null,
        sunset: null,
      ),
    );
    try {
      final city = await _cityRepo.getSavedCity();
      if (city == null) {
        emit(state.copyWith(isLoading: false, errorMessage: 'Город не выбран'));
        return;
      }
      final rawPrayers = await _prayerApi.getPrayerTime(
        city.name,
        DateTime.now(),
        2,
      );
      final rawSun = await _prayerApi.getSunTimes(city.name, DateTime.now(), 1);
      emit(
        state.copyWith(
          prayerTimes: rawPrayers.split(', ').toList(),
          sunrise: _parseTime(rawSun['sunrise']!),
          sunset: _parseTime(rawSun['sunset']!),
          isLoading: false,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Не удалось загрузить данные',
        ),
      );
    }
  }

  DateTime _parseTime(String timeStr) {
    final now = DateTime.now();
    final parts = timeStr.split(':');
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }
}
