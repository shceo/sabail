import 'package:bloc/bloc.dart';
import '../domain/api/quran_api.dart' show Surah, QuranApiService;

class SurahCacheState {
  final List<Surah> surahs;
  const SurahCacheState({this.surahs = const []});

  SurahCacheState copyWith({List<Surah>? surahs}) {
    return SurahCacheState(surahs: surahs ?? this.surahs);
  }
}

class SurahCacheCubit extends Cubit<SurahCacheState> {
  SurahCacheCubit() : super(const SurahCacheState());

  Future<void> loadSurahs() async {
    try {
      final surahs = await QuranApiService.fetchChapters();
      emit(state.copyWith(surahs: surahs));
    } catch (e) {
      // ignore errors for now
    }
  }
}
