import 'package:bloc/bloc.dart';
import '../domain/sql/last_read_dao.dart';

class LastReadState {
  final String surahName;
  final int surahNumber;
  final int verseNumber;
  const LastReadState({
    this.surahName = '',
    this.surahNumber = 1,
    this.verseNumber = 1,
  });

  LastReadState copyWith({
    String? surahName,
    int? surahNumber,
    int? verseNumber,
  }) {
    return LastReadState(
      surahName: surahName ?? this.surahName,
      surahNumber: surahNumber ?? this.surahNumber,
      verseNumber: verseNumber ?? this.verseNumber,
    );
  }
}

class LastReadCubit extends Cubit<LastReadState> {
  final LastReadDao _dao = LastReadDao();
  LastReadCubit() : super(const LastReadState()) {
    loadLastRead();
  }

  Future<void> saveLastRead() async {
    await _dao.saveLastRead(state.surahNumber, state.verseNumber);
  }

  Future<void> loadLastRead() async {
    final lastRead = await _dao.getLastRead();
    if (lastRead != null) {
      emit(
        state.copyWith(
          surahNumber: lastRead['surah_number'] ?? 1,
          verseNumber: lastRead['verse_number'] ?? 1,
          surahName: lastRead['surah_name'] ?? '',
        ),
      );
    }
  }

  void setLastReadSurah(String surahName) {
    emit(state.copyWith(surahName: surahName));
  }

  void setLastReadSurahNumber(int surahNumber) {
    emit(state.copyWith(surahNumber: surahNumber));
  }

  void setLastReadVerse(int verseNumber) {
    emit(state.copyWith(verseNumber: verseNumber));
    saveLastRead();
  }
}
