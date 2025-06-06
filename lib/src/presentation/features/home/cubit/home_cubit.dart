import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import '../../../../domain/api/api.dart';
import '../../../../domain/entities/city.dart';
import '../../../../domain/repositories/city_repository.dart';

class HomeState {
  final int currentIndex;
  final String hijriDate;
  final int monthNumber;
  final String currentTime;
  final String selectedCity;
  final List<String> prayerTimes;

  const HomeState({
    this.currentIndex = 0,
    this.hijriDate = '',
    this.monthNumber = 1,
    this.currentTime = '',
    this.selectedCity = '',
    this.prayerTimes = const [
      'Fajr: --:--',
      'Dhuhr: --:--',
      'Asr: --:--',
      'Maghrib: --:--',
      'Isha: --:--',
    ],
  });

  HomeState copyWith({
    int? currentIndex,
    String? hijriDate,
    int? monthNumber,
    String? currentTime,
    String? selectedCity,
    List<String>? prayerTimes,
  }) {
    return HomeState(
      currentIndex: currentIndex ?? this.currentIndex,
      hijriDate: hijriDate ?? this.hijriDate,
      monthNumber: monthNumber ?? this.monthNumber,
      currentTime: currentTime ?? this.currentTime,
      selectedCity: selectedCity ?? this.selectedCity,
      prayerTimes: prayerTimes ?? this.prayerTimes,
    );
  }
}

class HomeCubit extends Cubit<HomeState> {
  final HijriApi _hijriApi;
  final PrayerTimes _prayerApi;
  final CityRepository _cityRepo;

  StreamSubscription<String>? _hijriSub;
  Timer? _clockTimer;

  HomeCubit({
    required HijriApi hijriApi,
    required PrayerTimes prayerApi,
    required CityRepository cityRepo,
  }) : _hijriApi = hijriApi,
       _prayerApi = prayerApi,
       _cityRepo = cityRepo,
       super(const HomeState()) {
    _init();
  }

  Future<void> _init() async {
    final city = await _cityRepo.getSavedCity();
    emit(state.copyWith(selectedCity: city?.name ?? ''));
    _startClock();
    _hijriSub = _hijriApi.getCurrentHijriDateStream().listen((date) {
      final month = _parseHijriMonth(date);
      emit(state.copyWith(hijriDate: date, monthNumber: month));
    });
    await _loadPrayerTimes();
  }

  void selectTab(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  void _startClock() {
    _updateTime();
    _clockTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateTime(),
    );
  }

  void _updateTime() {
    final time = DateFormat('HH:mm:ss').format(DateTime.now());
    emit(state.copyWith(currentTime: time));
  }

  int _parseHijriMonth(String hijri) {
    try {
      final parts = hijri.split('/');
      return int.parse(parts[1]);
    } catch (_) {
      return 1;
    }
  }

  Future<void> _loadPrayerTimes() async {
    if (state.selectedCity.isEmpty) return;
    try {
      final raw = await _prayerApi.getPrayerTime(
        state.selectedCity,
        DateTime.now(),
        2,
      );
      emit(state.copyWith(prayerTimes: raw.split(', ').toList()));
    } catch (_) {}
  }

  Future<void> selectCity(String city) async {
    emit(state.copyWith(selectedCity: city));
    await _cityRepo.saveCity(City(id: 0, name: city));
    await _loadPrayerTimes();
  }

  @override
  Future<void> close() {
    _hijriSub?.cancel();
    _clockTimer?.cancel();
    return super.close();
  }
}
