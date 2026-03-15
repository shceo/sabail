// Data models for Quran API (alquran.cloud)

class SurahInfo {
  final int number;
  final String name; // Arabic name
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType; // Meccan / Medinan

  const SurahInfo({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory SurahInfo.fromJson(Map<String, dynamic> json) {
    return SurahInfo(
      number: json['number'] as int,
      name: json['name'] as String,
      englishName: json['englishName'] as String,
      englishNameTranslation: json['englishNameTranslation'] as String,
      numberOfAyahs: json['numberOfAyahs'] as int,
      revelationType: json['revelationType'] as String,
    );
  }

  /// Russian name for surah
  String get russianName => surahNamesRu[number] ?? englishName;

  /// Russian revelation type
  String get revelationTypeRu =>
      revelationType == 'Meccan' ? 'Мекканская' : 'Мединская';

  static const Map<int, String> surahNamesRu = {
    1: 'аль-Фатиха',
    2: 'аль-Бакара',
    3: 'Алю \'имран',
    4: 'ан-Ниса\'',
    5: 'аль-Маида',
    6: 'аль-Ан\'ам',
    7: 'аль-А\'раф',
    8: 'аль-Анфаль',
    9: 'ат-Тавба',
    10: 'Юнус',
    11: 'Худ',
    12: 'Юсуф',
    13: 'ар-Ра\'д',
    14: 'Ибрахим',
    15: 'аль-Хиджр',
    16: 'ан-Нахль',
    17: 'аль-Исра',
    18: 'аль-Кахф',
    19: 'Марьям',
    20: 'Та Ха',
    21: 'аль-Анбия',
    22: 'аль-Хадж',
    23: 'аль-Му\'минун',
    24: 'ан-Нур',
    25: 'аль-Фуркан',
    26: 'аш-Шу\'ара',
    27: 'ан-Намль',
    28: 'аль-Касас',
    29: 'аль-Анкабут',
    30: 'ар-Рум',
    31: 'Лукман',
    32: 'ас-Саджда',
    33: 'аль-Ахзаб',
    34: 'Саба',
    35: 'Фатыр',
    36: 'Йа Син',
    37: 'ас-Саффат',
    38: 'Сад',
    39: 'аз-Зумар',
    40: 'Гафир',
    41: 'Фуссылят',
    42: 'аш-Шура',
    43: 'аз-Зухруф',
    44: 'ад-Духан',
    45: 'аль-Джасия',
    46: 'аль-Ахкаф',
    47: 'Мухаммад',
    48: 'аль-Фатх',
    49: 'аль-Худжурат',
    50: 'Каф',
    51: 'аз-Зарият',
    52: 'ат-Тур',
    53: 'ан-Наджм',
    54: 'аль-Камар',
    55: 'ар-Рахман',
    56: 'аль-Вакы\'а',
    57: 'аль-Хадид',
    58: 'аль-Муджадила',
    59: 'аль-Хашр',
    60: 'аль-Мумтахана',
    61: 'ас-Сафф',
    62: 'аль-Джуму\'а',
    63: 'аль-Мунафикун',
    64: 'ат-Тагабун',
    65: 'ат-Талак',
    66: 'ат-Тахрим',
    67: 'аль-Мульк',
    68: 'аль-Калам',
    69: 'аль-Хакка',
    70: 'аль-Ма\'аридж',
    71: 'Нух',
    72: 'аль-Джинн',
    73: 'аль-Муззаммиль',
    74: 'аль-Муддассир',
    75: 'аль-Кыяма',
    76: 'аль-Инсан',
    77: 'аль-Мурсалят',
    78: 'ан-Наба',
    79: 'ан-Нази\'ат',
    80: '\'Абаса',
    81: 'ат-Таквир',
    82: 'аль-Инфитар',
    83: 'аль-Мутаффифин',
    84: 'аль-Иншикак',
    85: 'аль-Бурудж',
    86: 'ат-Тарик',
    87: 'аль-А\'ля',
    88: 'аль-Гашия',
    89: 'аль-Фаджр',
    90: 'аль-Балад',
    91: 'аш-Шамс',
    92: 'аль-Лейль',
    93: 'ад-Духа',
    94: 'аш-Шарх',
    95: 'ат-Тин',
    96: 'аль-\'Алак',
    97: 'аль-Кадр',
    98: 'аль-Баййина',
    99: 'аз-Зальзала',
    100: 'аль-\'Адият',
    101: 'аль-Кари\'а',
    102: 'ат-Такасур',
    103: 'аль-\'Аср',
    104: 'аль-Хумаза',
    105: 'аль-Филь',
    106: 'Курайш',
    107: 'аль-Ма\'ун',
    108: 'аль-Каусар',
    109: 'аль-Кафирун',
    110: 'ан-Наср',
    111: 'аль-Масад',
    112: 'аль-Ихлас',
    113: 'аль-Фаляк',
    114: 'ан-Нас',
  };
}

class Ayah {
  final int number;
  final String text;
  final int numberInSurah;
  final int juz;
  final int page;
  final int? hizbQuarter;
  final int? surahNumber;
  final String? surahName;

  const Ayah({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.page,
    this.hizbQuarter,
    this.surahNumber,
    this.surahName,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    final surah = json['surah'] as Map<String, dynamic>?;
    return Ayah(
      number: json['number'] as int,
      text: json['text'] as String,
      numberInSurah: json['numberInSurah'] as int,
      juz: json['juz'] as int,
      page: json['page'] as int,
      hizbQuarter: json['hizbQuarter'] as int?,
      surahNumber: surah?['number'] as int?,
      surahName: surah?['name'] as String?,
    );
  }
}

class JuzInfo {
  final int number;
  final List<JuzSurahRef> surahRefs;

  const JuzInfo({required this.number, required this.surahRefs});
}

class JuzSurahRef {
  final int surahNumber;
  final String surahName;
  final int startAyah;

  const JuzSurahRef({
    required this.surahNumber,
    required this.surahName,
    required this.startAyah,
  });
}

/// Static juz-to-surah mapping (standard Quran division)
class JuzData {
  static const List<JuzInfo> allJuz = [
    JuzInfo(number: 1, surahRefs: [JuzSurahRef(surahNumber: 1, surahName: 'аль-Фатиха', startAyah: 1)]),
    JuzInfo(number: 2, surahRefs: [JuzSurahRef(surahNumber: 2, surahName: 'аль-Бакара', startAyah: 142)]),
    JuzInfo(number: 3, surahRefs: [JuzSurahRef(surahNumber: 2, surahName: 'аль-Бакара', startAyah: 253)]),
    JuzInfo(number: 4, surahRefs: [JuzSurahRef(surahNumber: 3, surahName: 'Алю \'имран', startAyah: 93)]),
    JuzInfo(number: 5, surahRefs: [JuzSurahRef(surahNumber: 4, surahName: 'ан-Ниса\'', startAyah: 24)]),
    JuzInfo(number: 6, surahRefs: [JuzSurahRef(surahNumber: 4, surahName: 'ан-Ниса\'', startAyah: 148)]),
    JuzInfo(number: 7, surahRefs: [JuzSurahRef(surahNumber: 5, surahName: 'аль-Маида', startAyah: 83)]),
    JuzInfo(number: 8, surahRefs: [JuzSurahRef(surahNumber: 6, surahName: 'аль-Ан\'ам', startAyah: 111)]),
    JuzInfo(number: 9, surahRefs: [JuzSurahRef(surahNumber: 7, surahName: 'аль-А\'раф', startAyah: 88)]),
    JuzInfo(number: 10, surahRefs: [JuzSurahRef(surahNumber: 8, surahName: 'аль-Анфаль', startAyah: 41)]),
    JuzInfo(number: 11, surahRefs: [JuzSurahRef(surahNumber: 9, surahName: 'ат-Тавба', startAyah: 93)]),
    JuzInfo(number: 12, surahRefs: [JuzSurahRef(surahNumber: 11, surahName: 'Худ', startAyah: 6)]),
    JuzInfo(number: 13, surahRefs: [JuzSurahRef(surahNumber: 12, surahName: 'Юсуф', startAyah: 53)]),
    JuzInfo(number: 14, surahRefs: [JuzSurahRef(surahNumber: 15, surahName: 'аль-Хиджр', startAyah: 1)]),
    JuzInfo(number: 15, surahRefs: [JuzSurahRef(surahNumber: 17, surahName: 'аль-Исра', startAyah: 1)]),
    JuzInfo(number: 16, surahRefs: [JuzSurahRef(surahNumber: 18, surahName: 'аль-Кахф', startAyah: 75)]),
    JuzInfo(number: 17, surahRefs: [JuzSurahRef(surahNumber: 21, surahName: 'аль-Анбия', startAyah: 1)]),
    JuzInfo(number: 18, surahRefs: [JuzSurahRef(surahNumber: 23, surahName: 'аль-Му\'минун', startAyah: 1)]),
    JuzInfo(number: 19, surahRefs: [JuzSurahRef(surahNumber: 25, surahName: 'аль-Фуркан', startAyah: 21)]),
    JuzInfo(number: 20, surahRefs: [JuzSurahRef(surahNumber: 27, surahName: 'ан-Намль', startAyah: 56)]),
    JuzInfo(number: 21, surahRefs: [JuzSurahRef(surahNumber: 29, surahName: 'аль-Анкабут', startAyah: 46)]),
    JuzInfo(number: 22, surahRefs: [JuzSurahRef(surahNumber: 33, surahName: 'аль-Ахзаб', startAyah: 31)]),
    JuzInfo(number: 23, surahRefs: [JuzSurahRef(surahNumber: 36, surahName: 'Йа Син', startAyah: 28)]),
    JuzInfo(number: 24, surahRefs: [JuzSurahRef(surahNumber: 39, surahName: 'аз-Зумар', startAyah: 32)]),
    JuzInfo(number: 25, surahRefs: [JuzSurahRef(surahNumber: 41, surahName: 'Фуссылят', startAyah: 47)]),
    JuzInfo(number: 26, surahRefs: [JuzSurahRef(surahNumber: 46, surahName: 'аль-Ахкаф', startAyah: 1)]),
    JuzInfo(number: 27, surahRefs: [JuzSurahRef(surahNumber: 51, surahName: 'аз-Зарият', startAyah: 31)]),
    JuzInfo(number: 28, surahRefs: [JuzSurahRef(surahNumber: 58, surahName: 'аль-Муджадила', startAyah: 1)]),
    JuzInfo(number: 29, surahRefs: [JuzSurahRef(surahNumber: 67, surahName: 'аль-Мульк', startAyah: 1)]),
    JuzInfo(number: 30, surahRefs: [JuzSurahRef(surahNumber: 78, surahName: 'ан-Наба', startAyah: 1)]),
  ];
}
