// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $SurahsTable extends Surahs with TableInfo<$SurahsTable, Surah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arabicTextMeta = const VerificationMeta(
    'arabicText',
  );
  @override
  late final GeneratedColumn<String> arabicText = GeneratedColumn<String>(
    'arabic_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationMeta = const VerificationMeta(
    'translation',
  );
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
    'translation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, arabicText, translation];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'surahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Surah> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('arabic_text')) {
      context.handle(
        _arabicTextMeta,
        arabicText.isAcceptableOrUnknown(data['arabic_text']!, _arabicTextMeta),
      );
    } else if (isInserting) {
      context.missing(_arabicTextMeta);
    }
    if (data.containsKey('translation')) {
      context.handle(
        _translationMeta,
        translation.isAcceptableOrUnknown(
          data['translation']!,
          _translationMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Surah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Surah(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      arabicText:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}arabic_text'],
          )!,
      translation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation'],
      ),
    );
  }

  @override
  $SurahsTable createAlias(String alias) {
    return $SurahsTable(attachedDatabase, alias);
  }
}

class Surah extends DataClass implements Insertable<Surah> {
  final int id;
  final String name;
  final String arabicText;
  final String? translation;
  const Surah({
    required this.id,
    required this.name,
    required this.arabicText,
    this.translation,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['arabic_text'] = Variable<String>(arabicText);
    if (!nullToAbsent || translation != null) {
      map['translation'] = Variable<String>(translation);
    }
    return map;
  }

  SurahsCompanion toCompanion(bool nullToAbsent) {
    return SurahsCompanion(
      id: Value(id),
      name: Value(name),
      arabicText: Value(arabicText),
      translation:
          translation == null && nullToAbsent
              ? const Value.absent()
              : Value(translation),
    );
  }

  factory Surah.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Surah(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      arabicText: serializer.fromJson<String>(json['arabicText']),
      translation: serializer.fromJson<String?>(json['translation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'arabicText': serializer.toJson<String>(arabicText),
      'translation': serializer.toJson<String?>(translation),
    };
  }

  Surah copyWith({
    int? id,
    String? name,
    String? arabicText,
    Value<String?> translation = const Value.absent(),
  }) => Surah(
    id: id ?? this.id,
    name: name ?? this.name,
    arabicText: arabicText ?? this.arabicText,
    translation: translation.present ? translation.value : this.translation,
  );
  Surah copyWithCompanion(SurahsCompanion data) {
    return Surah(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      arabicText:
          data.arabicText.present ? data.arabicText.value : this.arabicText,
      translation:
          data.translation.present ? data.translation.value : this.translation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Surah(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('arabicText: $arabicText, ')
          ..write('translation: $translation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, arabicText, translation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Surah &&
          other.id == this.id &&
          other.name == this.name &&
          other.arabicText == this.arabicText &&
          other.translation == this.translation);
}

class SurahsCompanion extends UpdateCompanion<Surah> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> arabicText;
  final Value<String?> translation;
  const SurahsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.arabicText = const Value.absent(),
    this.translation = const Value.absent(),
  });
  SurahsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String arabicText,
    this.translation = const Value.absent(),
  }) : name = Value(name),
       arabicText = Value(arabicText);
  static Insertable<Surah> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? arabicText,
    Expression<String>? translation,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (arabicText != null) 'arabic_text': arabicText,
      if (translation != null) 'translation': translation,
    });
  }

  SurahsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? arabicText,
    Value<String?>? translation,
  }) {
    return SurahsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      arabicText: arabicText ?? this.arabicText,
      translation: translation ?? this.translation,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (arabicText.present) {
      map['arabic_text'] = Variable<String>(arabicText.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurahsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('arabicText: $arabicText, ')
          ..write('translation: $translation')
          ..write(')'))
        .toString();
  }
}

class $AyahsTable extends Ayahs with TableInfo<$AyahsTable, Ayah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AyahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _surahIdMeta = const VerificationMeta(
    'surahId',
  );
  @override
  late final GeneratedColumn<int> surahId = GeneratedColumn<int>(
    'surah_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES surahs (id)',
    ),
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahTextMeta = const VerificationMeta(
    'ayahText',
  );
  @override
  late final GeneratedColumn<String> ayahText = GeneratedColumn<String>(
    'ayah_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, surahId, number, ayahText];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ayahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ayah> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('surah_id')) {
      context.handle(
        _surahIdMeta,
        surahId.isAcceptableOrUnknown(data['surah_id']!, _surahIdMeta),
      );
    } else if (isInserting) {
      context.missing(_surahIdMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('ayah_text')) {
      context.handle(
        _ayahTextMeta,
        ayahText.isAcceptableOrUnknown(data['ayah_text']!, _ayahTextMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ayah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ayah(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      surahId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}surah_id'],
          )!,
      number:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}number'],
          )!,
      ayahText:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}ayah_text'],
          )!,
    );
  }

  @override
  $AyahsTable createAlias(String alias) {
    return $AyahsTable(attachedDatabase, alias);
  }
}

class Ayah extends DataClass implements Insertable<Ayah> {
  final int id;
  final int surahId;
  final int number;
  final String ayahText;
  const Ayah({
    required this.id,
    required this.surahId,
    required this.number,
    required this.ayahText,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['surah_id'] = Variable<int>(surahId);
    map['number'] = Variable<int>(number);
    map['ayah_text'] = Variable<String>(ayahText);
    return map;
  }

  AyahsCompanion toCompanion(bool nullToAbsent) {
    return AyahsCompanion(
      id: Value(id),
      surahId: Value(surahId),
      number: Value(number),
      ayahText: Value(ayahText),
    );
  }

  factory Ayah.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ayah(
      id: serializer.fromJson<int>(json['id']),
      surahId: serializer.fromJson<int>(json['surahId']),
      number: serializer.fromJson<int>(json['number']),
      ayahText: serializer.fromJson<String>(json['ayahText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'surahId': serializer.toJson<int>(surahId),
      'number': serializer.toJson<int>(number),
      'ayahText': serializer.toJson<String>(ayahText),
    };
  }

  Ayah copyWith({int? id, int? surahId, int? number, String? ayahText}) => Ayah(
    id: id ?? this.id,
    surahId: surahId ?? this.surahId,
    number: number ?? this.number,
    ayahText: ayahText ?? this.ayahText,
  );
  Ayah copyWithCompanion(AyahsCompanion data) {
    return Ayah(
      id: data.id.present ? data.id.value : this.id,
      surahId: data.surahId.present ? data.surahId.value : this.surahId,
      number: data.number.present ? data.number.value : this.number,
      ayahText: data.ayahText.present ? data.ayahText.value : this.ayahText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ayah(')
          ..write('id: $id, ')
          ..write('surahId: $surahId, ')
          ..write('number: $number, ')
          ..write('ayahText: $ayahText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, surahId, number, ayahText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ayah &&
          other.id == this.id &&
          other.surahId == this.surahId &&
          other.number == this.number &&
          other.ayahText == this.ayahText);
}

class AyahsCompanion extends UpdateCompanion<Ayah> {
  final Value<int> id;
  final Value<int> surahId;
  final Value<int> number;
  final Value<String> ayahText;
  const AyahsCompanion({
    this.id = const Value.absent(),
    this.surahId = const Value.absent(),
    this.number = const Value.absent(),
    this.ayahText = const Value.absent(),
  });
  AyahsCompanion.insert({
    this.id = const Value.absent(),
    required int surahId,
    required int number,
    required String ayahText,
  }) : surahId = Value(surahId),
       number = Value(number),
       ayahText = Value(ayahText);
  static Insertable<Ayah> custom({
    Expression<int>? id,
    Expression<int>? surahId,
    Expression<int>? number,
    Expression<String>? ayahText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (surahId != null) 'surah_id': surahId,
      if (number != null) 'number': number,
      if (ayahText != null) 'ayah_text': ayahText,
    });
  }

  AyahsCompanion copyWith({
    Value<int>? id,
    Value<int>? surahId,
    Value<int>? number,
    Value<String>? ayahText,
  }) {
    return AyahsCompanion(
      id: id ?? this.id,
      surahId: surahId ?? this.surahId,
      number: number ?? this.number,
      ayahText: ayahText ?? this.ayahText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (surahId.present) {
      map['surah_id'] = Variable<int>(surahId.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (ayahText.present) {
      map['ayah_text'] = Variable<String>(ayahText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AyahsCompanion(')
          ..write('id: $id, ')
          ..write('surahId: $surahId, ')
          ..write('number: $number, ')
          ..write('ayahText: $ayahText')
          ..write(')'))
        .toString();
  }
}

class $HadithsTable extends Hadiths with TableInfo<$HadithsTable, Hadith> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HadithsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bookMeta = const VerificationMeta('book');
  @override
  late final GeneratedColumn<String> book = GeneratedColumn<String>(
    'book',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chapterMeta = const VerificationMeta(
    'chapter',
  );
  @override
  late final GeneratedColumn<String> chapter = GeneratedColumn<String>(
    'chapter',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hadithTextMeta = const VerificationMeta(
    'hadithText',
  );
  @override
  late final GeneratedColumn<String> hadithText = GeneratedColumn<String>(
    'hadith_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, book, chapter, hadithText];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hadiths';
  @override
  VerificationContext validateIntegrity(
    Insertable<Hadith> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book')) {
      context.handle(
        _bookMeta,
        book.isAcceptableOrUnknown(data['book']!, _bookMeta),
      );
    } else if (isInserting) {
      context.missing(_bookMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(
        _chapterMeta,
        chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta),
      );
    }
    if (data.containsKey('hadith_text')) {
      context.handle(
        _hadithTextMeta,
        hadithText.isAcceptableOrUnknown(data['hadith_text']!, _hadithTextMeta),
      );
    } else if (isInserting) {
      context.missing(_hadithTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Hadith map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Hadith(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      book:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}book'],
          )!,
      chapter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter'],
      ),
      hadithText:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}hadith_text'],
          )!,
    );
  }

  @override
  $HadithsTable createAlias(String alias) {
    return $HadithsTable(attachedDatabase, alias);
  }
}

class Hadith extends DataClass implements Insertable<Hadith> {
  final int id;
  final String book;
  final String? chapter;
  final String hadithText;
  const Hadith({
    required this.id,
    required this.book,
    this.chapter,
    required this.hadithText,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book'] = Variable<String>(book);
    if (!nullToAbsent || chapter != null) {
      map['chapter'] = Variable<String>(chapter);
    }
    map['hadith_text'] = Variable<String>(hadithText);
    return map;
  }

  HadithsCompanion toCompanion(bool nullToAbsent) {
    return HadithsCompanion(
      id: Value(id),
      book: Value(book),
      chapter:
          chapter == null && nullToAbsent
              ? const Value.absent()
              : Value(chapter),
      hadithText: Value(hadithText),
    );
  }

  factory Hadith.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Hadith(
      id: serializer.fromJson<int>(json['id']),
      book: serializer.fromJson<String>(json['book']),
      chapter: serializer.fromJson<String?>(json['chapter']),
      hadithText: serializer.fromJson<String>(json['hadithText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'book': serializer.toJson<String>(book),
      'chapter': serializer.toJson<String?>(chapter),
      'hadithText': serializer.toJson<String>(hadithText),
    };
  }

  Hadith copyWith({
    int? id,
    String? book,
    Value<String?> chapter = const Value.absent(),
    String? hadithText,
  }) => Hadith(
    id: id ?? this.id,
    book: book ?? this.book,
    chapter: chapter.present ? chapter.value : this.chapter,
    hadithText: hadithText ?? this.hadithText,
  );
  Hadith copyWithCompanion(HadithsCompanion data) {
    return Hadith(
      id: data.id.present ? data.id.value : this.id,
      book: data.book.present ? data.book.value : this.book,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      hadithText:
          data.hadithText.present ? data.hadithText.value : this.hadithText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Hadith(')
          ..write('id: $id, ')
          ..write('book: $book, ')
          ..write('chapter: $chapter, ')
          ..write('hadithText: $hadithText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, book, chapter, hadithText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Hadith &&
          other.id == this.id &&
          other.book == this.book &&
          other.chapter == this.chapter &&
          other.hadithText == this.hadithText);
}

class HadithsCompanion extends UpdateCompanion<Hadith> {
  final Value<int> id;
  final Value<String> book;
  final Value<String?> chapter;
  final Value<String> hadithText;
  const HadithsCompanion({
    this.id = const Value.absent(),
    this.book = const Value.absent(),
    this.chapter = const Value.absent(),
    this.hadithText = const Value.absent(),
  });
  HadithsCompanion.insert({
    this.id = const Value.absent(),
    required String book,
    this.chapter = const Value.absent(),
    required String hadithText,
  }) : book = Value(book),
       hadithText = Value(hadithText);
  static Insertable<Hadith> custom({
    Expression<int>? id,
    Expression<String>? book,
    Expression<String>? chapter,
    Expression<String>? hadithText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (book != null) 'book': book,
      if (chapter != null) 'chapter': chapter,
      if (hadithText != null) 'hadith_text': hadithText,
    });
  }

  HadithsCompanion copyWith({
    Value<int>? id,
    Value<String>? book,
    Value<String?>? chapter,
    Value<String>? hadithText,
  }) {
    return HadithsCompanion(
      id: id ?? this.id,
      book: book ?? this.book,
      chapter: chapter ?? this.chapter,
      hadithText: hadithText ?? this.hadithText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (book.present) {
      map['book'] = Variable<String>(book.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<String>(chapter.value);
    }
    if (hadithText.present) {
      map['hadith_text'] = Variable<String>(hadithText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HadithsCompanion(')
          ..write('id: $id, ')
          ..write('book: $book, ')
          ..write('chapter: $chapter, ')
          ..write('hadithText: $hadithText')
          ..write(')'))
        .toString();
  }
}

class $TasbihSessionsTable extends TasbihSessions
    with TableInfo<$TasbihSessionsTable, TasbihSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasbihSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, count];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasbih_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TasbihSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TasbihSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TasbihSession(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      count:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}count'],
          )!,
    );
  }

  @override
  $TasbihSessionsTable createAlias(String alias) {
    return $TasbihSessionsTable(attachedDatabase, alias);
  }
}

class TasbihSession extends DataClass implements Insertable<TasbihSession> {
  final int id;
  final String? name;
  final int count;
  const TasbihSession({required this.id, this.name, required this.count});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['count'] = Variable<int>(count);
    return map;
  }

  TasbihSessionsCompanion toCompanion(bool nullToAbsent) {
    return TasbihSessionsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      count: Value(count),
    );
  }

  factory TasbihSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TasbihSession(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      count: serializer.fromJson<int>(json['count']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'count': serializer.toJson<int>(count),
    };
  }

  TasbihSession copyWith({
    int? id,
    Value<String?> name = const Value.absent(),
    int? count,
  }) => TasbihSession(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    count: count ?? this.count,
  );
  TasbihSession copyWithCompanion(TasbihSessionsCompanion data) {
    return TasbihSession(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      count: data.count.present ? data.count.value : this.count,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TasbihSession(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, count);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TasbihSession &&
          other.id == this.id &&
          other.name == this.name &&
          other.count == this.count);
}

class TasbihSessionsCompanion extends UpdateCompanion<TasbihSession> {
  final Value<int> id;
  final Value<String?> name;
  final Value<int> count;
  const TasbihSessionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.count = const Value.absent(),
  });
  TasbihSessionsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.count = const Value.absent(),
  });
  static Insertable<TasbihSession> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? count,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (count != null) 'count': count,
    });
  }

  TasbihSessionsCompanion copyWith({
    Value<int>? id,
    Value<String?>? name,
    Value<int>? count,
  }) {
    return TasbihSessionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasbihSessionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }
}

class $PrayerTimesTable extends PrayerTimes
    with TableInfo<$PrayerTimesTable, PrayerTime> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrayerTimesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fajrMeta = const VerificationMeta('fajr');
  @override
  late final GeneratedColumn<int> fajr = GeneratedColumn<int>(
    'fajr',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dhuhrMeta = const VerificationMeta('dhuhr');
  @override
  late final GeneratedColumn<int> dhuhr = GeneratedColumn<int>(
    'dhuhr',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _asrMeta = const VerificationMeta('asr');
  @override
  late final GeneratedColumn<int> asr = GeneratedColumn<int>(
    'asr',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maghribMeta = const VerificationMeta(
    'maghrib',
  );
  @override
  late final GeneratedColumn<int> maghrib = GeneratedColumn<int>(
    'maghrib',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ishaMeta = const VerificationMeta('isha');
  @override
  late final GeneratedColumn<int> isha = GeneratedColumn<int>(
    'isha',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    fajr,
    dhuhr,
    asr,
    maghrib,
    isha,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prayer_times';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrayerTime> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('fajr')) {
      context.handle(
        _fajrMeta,
        fajr.isAcceptableOrUnknown(data['fajr']!, _fajrMeta),
      );
    } else if (isInserting) {
      context.missing(_fajrMeta);
    }
    if (data.containsKey('dhuhr')) {
      context.handle(
        _dhuhrMeta,
        dhuhr.isAcceptableOrUnknown(data['dhuhr']!, _dhuhrMeta),
      );
    } else if (isInserting) {
      context.missing(_dhuhrMeta);
    }
    if (data.containsKey('asr')) {
      context.handle(
        _asrMeta,
        asr.isAcceptableOrUnknown(data['asr']!, _asrMeta),
      );
    } else if (isInserting) {
      context.missing(_asrMeta);
    }
    if (data.containsKey('maghrib')) {
      context.handle(
        _maghribMeta,
        maghrib.isAcceptableOrUnknown(data['maghrib']!, _maghribMeta),
      );
    } else if (isInserting) {
      context.missing(_maghribMeta);
    }
    if (data.containsKey('isha')) {
      context.handle(
        _ishaMeta,
        isha.isAcceptableOrUnknown(data['isha']!, _ishaMeta),
      );
    } else if (isInserting) {
      context.missing(_ishaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrayerTime map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrayerTime(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
      fajr:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}fajr'],
          )!,
      dhuhr:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}dhuhr'],
          )!,
      asr:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}asr'],
          )!,
      maghrib:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}maghrib'],
          )!,
      isha:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}isha'],
          )!,
    );
  }

  @override
  $PrayerTimesTable createAlias(String alias) {
    return $PrayerTimesTable(attachedDatabase, alias);
  }
}

class PrayerTime extends DataClass implements Insertable<PrayerTime> {
  final int id;
  final DateTime date;
  final int fajr;
  final int dhuhr;
  final int asr;
  final int maghrib;
  final int isha;
  const PrayerTime({
    required this.id,
    required this.date,
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['fajr'] = Variable<int>(fajr);
    map['dhuhr'] = Variable<int>(dhuhr);
    map['asr'] = Variable<int>(asr);
    map['maghrib'] = Variable<int>(maghrib);
    map['isha'] = Variable<int>(isha);
    return map;
  }

  PrayerTimesCompanion toCompanion(bool nullToAbsent) {
    return PrayerTimesCompanion(
      id: Value(id),
      date: Value(date),
      fajr: Value(fajr),
      dhuhr: Value(dhuhr),
      asr: Value(asr),
      maghrib: Value(maghrib),
      isha: Value(isha),
    );
  }

  factory PrayerTime.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrayerTime(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      fajr: serializer.fromJson<int>(json['fajr']),
      dhuhr: serializer.fromJson<int>(json['dhuhr']),
      asr: serializer.fromJson<int>(json['asr']),
      maghrib: serializer.fromJson<int>(json['maghrib']),
      isha: serializer.fromJson<int>(json['isha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'fajr': serializer.toJson<int>(fajr),
      'dhuhr': serializer.toJson<int>(dhuhr),
      'asr': serializer.toJson<int>(asr),
      'maghrib': serializer.toJson<int>(maghrib),
      'isha': serializer.toJson<int>(isha),
    };
  }

  PrayerTime copyWith({
    int? id,
    DateTime? date,
    int? fajr,
    int? dhuhr,
    int? asr,
    int? maghrib,
    int? isha,
  }) => PrayerTime(
    id: id ?? this.id,
    date: date ?? this.date,
    fajr: fajr ?? this.fajr,
    dhuhr: dhuhr ?? this.dhuhr,
    asr: asr ?? this.asr,
    maghrib: maghrib ?? this.maghrib,
    isha: isha ?? this.isha,
  );
  PrayerTime copyWithCompanion(PrayerTimesCompanion data) {
    return PrayerTime(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      fajr: data.fajr.present ? data.fajr.value : this.fajr,
      dhuhr: data.dhuhr.present ? data.dhuhr.value : this.dhuhr,
      asr: data.asr.present ? data.asr.value : this.asr,
      maghrib: data.maghrib.present ? data.maghrib.value : this.maghrib,
      isha: data.isha.present ? data.isha.value : this.isha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrayerTime(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('fajr: $fajr, ')
          ..write('dhuhr: $dhuhr, ')
          ..write('asr: $asr, ')
          ..write('maghrib: $maghrib, ')
          ..write('isha: $isha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, fajr, dhuhr, asr, maghrib, isha);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrayerTime &&
          other.id == this.id &&
          other.date == this.date &&
          other.fajr == this.fajr &&
          other.dhuhr == this.dhuhr &&
          other.asr == this.asr &&
          other.maghrib == this.maghrib &&
          other.isha == this.isha);
}

class PrayerTimesCompanion extends UpdateCompanion<PrayerTime> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> fajr;
  final Value<int> dhuhr;
  final Value<int> asr;
  final Value<int> maghrib;
  final Value<int> isha;
  const PrayerTimesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.fajr = const Value.absent(),
    this.dhuhr = const Value.absent(),
    this.asr = const Value.absent(),
    this.maghrib = const Value.absent(),
    this.isha = const Value.absent(),
  });
  PrayerTimesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required int fajr,
    required int dhuhr,
    required int asr,
    required int maghrib,
    required int isha,
  }) : date = Value(date),
       fajr = Value(fajr),
       dhuhr = Value(dhuhr),
       asr = Value(asr),
       maghrib = Value(maghrib),
       isha = Value(isha);
  static Insertable<PrayerTime> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? fajr,
    Expression<int>? dhuhr,
    Expression<int>? asr,
    Expression<int>? maghrib,
    Expression<int>? isha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (fajr != null) 'fajr': fajr,
      if (dhuhr != null) 'dhuhr': dhuhr,
      if (asr != null) 'asr': asr,
      if (maghrib != null) 'maghrib': maghrib,
      if (isha != null) 'isha': isha,
    });
  }

  PrayerTimesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<int>? fajr,
    Value<int>? dhuhr,
    Value<int>? asr,
    Value<int>? maghrib,
    Value<int>? isha,
  }) {
    return PrayerTimesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      fajr: fajr ?? this.fajr,
      dhuhr: dhuhr ?? this.dhuhr,
      asr: asr ?? this.asr,
      maghrib: maghrib ?? this.maghrib,
      isha: isha ?? this.isha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (fajr.present) {
      map['fajr'] = Variable<int>(fajr.value);
    }
    if (dhuhr.present) {
      map['dhuhr'] = Variable<int>(dhuhr.value);
    }
    if (asr.present) {
      map['asr'] = Variable<int>(asr.value);
    }
    if (maghrib.present) {
      map['maghrib'] = Variable<int>(maghrib.value);
    }
    if (isha.present) {
      map['isha'] = Variable<int>(isha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrayerTimesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('fajr: $fajr, ')
          ..write('dhuhr: $dhuhr, ')
          ..write('asr: $asr, ')
          ..write('maghrib: $maghrib, ')
          ..write('isha: $isha')
          ..write(')'))
        .toString();
  }
}

class $DonationsTable extends Donations
    with TableInfo<$DonationsTable, Donation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DonationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _charityNameMeta = const VerificationMeta(
    'charityName',
  );
  @override
  late final GeneratedColumn<String> charityName = GeneratedColumn<String>(
    'charity_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, amount, date, charityName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'donations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Donation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('charity_name')) {
      context.handle(
        _charityNameMeta,
        charityName.isAcceptableOrUnknown(
          data['charity_name']!,
          _charityNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_charityNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Donation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Donation(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      amount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}amount'],
          )!,
      date:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}date'],
          )!,
      charityName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}charity_name'],
          )!,
    );
  }

  @override
  $DonationsTable createAlias(String alias) {
    return $DonationsTable(attachedDatabase, alias);
  }
}

class Donation extends DataClass implements Insertable<Donation> {
  final int id;
  final double amount;
  final DateTime date;
  final String charityName;
  const Donation({
    required this.id,
    required this.amount,
    required this.date,
    required this.charityName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    map['charity_name'] = Variable<String>(charityName);
    return map;
  }

  DonationsCompanion toCompanion(bool nullToAbsent) {
    return DonationsCompanion(
      id: Value(id),
      amount: Value(amount),
      date: Value(date),
      charityName: Value(charityName),
    );
  }

  factory Donation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Donation(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      charityName: serializer.fromJson<String>(json['charityName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'charityName': serializer.toJson<String>(charityName),
    };
  }

  Donation copyWith({
    int? id,
    double? amount,
    DateTime? date,
    String? charityName,
  }) => Donation(
    id: id ?? this.id,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    charityName: charityName ?? this.charityName,
  );
  Donation copyWithCompanion(DonationsCompanion data) {
    return Donation(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      charityName:
          data.charityName.present ? data.charityName.value : this.charityName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Donation(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('charityName: $charityName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amount, date, charityName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Donation &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.charityName == this.charityName);
}

class DonationsCompanion extends UpdateCompanion<Donation> {
  final Value<int> id;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String> charityName;
  const DonationsCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.charityName = const Value.absent(),
  });
  DonationsCompanion.insert({
    this.id = const Value.absent(),
    required double amount,
    this.date = const Value.absent(),
    required String charityName,
  }) : amount = Value(amount),
       charityName = Value(charityName);
  static Insertable<Donation> custom({
    Expression<int>? id,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? charityName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (charityName != null) 'charity_name': charityName,
    });
  }

  DonationsCompanion copyWith({
    Value<int>? id,
    Value<double>? amount,
    Value<DateTime>? date,
    Value<String>? charityName,
  }) {
    return DonationsCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      charityName: charityName ?? this.charityName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (charityName.present) {
      map['charity_name'] = Variable<String>(charityName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DonationsCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('charityName: $charityName')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SurahsTable surahs = $SurahsTable(this);
  late final $AyahsTable ayahs = $AyahsTable(this);
  late final $HadithsTable hadiths = $HadithsTable(this);
  late final $TasbihSessionsTable tasbihSessions = $TasbihSessionsTable(this);
  late final $PrayerTimesTable prayerTimes = $PrayerTimesTable(this);
  late final $DonationsTable donations = $DonationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    surahs,
    ayahs,
    hadiths,
    tasbihSessions,
    prayerTimes,
    donations,
  ];
}

typedef $$SurahsTableCreateCompanionBuilder =
    SurahsCompanion Function({
      Value<int> id,
      required String name,
      required String arabicText,
      Value<String?> translation,
    });
typedef $$SurahsTableUpdateCompanionBuilder =
    SurahsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> arabicText,
      Value<String?> translation,
    });

final class $$SurahsTableReferences
    extends BaseReferences<_$AppDatabase, $SurahsTable, Surah> {
  $$SurahsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AyahsTable, List<Ayah>> _ayahsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.ayahs,
    aliasName: $_aliasNameGenerator(db.surahs.id, db.ayahs.surahId),
  );

  $$AyahsTableProcessedTableManager get ayahsRefs {
    final manager = $$AyahsTableTableManager(
      $_db,
      $_db.ayahs,
    ).filter((f) => f.surahId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ayahsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SurahsTableFilterComposer
    extends Composer<_$AppDatabase, $SurahsTable> {
  $$SurahsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arabicText => $composableBuilder(
    column: $table.arabicText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ayahsRefs(
    Expression<bool> Function($$AyahsTableFilterComposer f) f,
  ) {
    final $$AyahsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ayahs,
      getReferencedColumn: (t) => t.surahId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AyahsTableFilterComposer(
            $db: $db,
            $table: $db.ayahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SurahsTableOrderingComposer
    extends Composer<_$AppDatabase, $SurahsTable> {
  $$SurahsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arabicText => $composableBuilder(
    column: $table.arabicText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SurahsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SurahsTable> {
  $$SurahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get arabicText => $composableBuilder(
    column: $table.arabicText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translation => $composableBuilder(
    column: $table.translation,
    builder: (column) => column,
  );

  Expression<T> ayahsRefs<T extends Object>(
    Expression<T> Function($$AyahsTableAnnotationComposer a) f,
  ) {
    final $$AyahsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ayahs,
      getReferencedColumn: (t) => t.surahId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AyahsTableAnnotationComposer(
            $db: $db,
            $table: $db.ayahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SurahsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SurahsTable,
          Surah,
          $$SurahsTableFilterComposer,
          $$SurahsTableOrderingComposer,
          $$SurahsTableAnnotationComposer,
          $$SurahsTableCreateCompanionBuilder,
          $$SurahsTableUpdateCompanionBuilder,
          (Surah, $$SurahsTableReferences),
          Surah,
          PrefetchHooks Function({bool ayahsRefs})
        > {
  $$SurahsTableTableManager(_$AppDatabase db, $SurahsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SurahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SurahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$SurahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> arabicText = const Value.absent(),
                Value<String?> translation = const Value.absent(),
              }) => SurahsCompanion(
                id: id,
                name: name,
                arabicText: arabicText,
                translation: translation,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String arabicText,
                Value<String?> translation = const Value.absent(),
              }) => SurahsCompanion.insert(
                id: id,
                name: name,
                arabicText: arabicText,
                translation: translation,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$SurahsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({ayahsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ayahsRefs) db.ayahs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ayahsRefs)
                    await $_getPrefetchedData<Surah, $SurahsTable, Ayah>(
                      currentTable: table,
                      referencedTable: $$SurahsTableReferences._ayahsRefsTable(
                        db,
                      ),
                      managerFromTypedResult:
                          (p0) =>
                              $$SurahsTableReferences(db, table, p0).ayahsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.surahId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SurahsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SurahsTable,
      Surah,
      $$SurahsTableFilterComposer,
      $$SurahsTableOrderingComposer,
      $$SurahsTableAnnotationComposer,
      $$SurahsTableCreateCompanionBuilder,
      $$SurahsTableUpdateCompanionBuilder,
      (Surah, $$SurahsTableReferences),
      Surah,
      PrefetchHooks Function({bool ayahsRefs})
    >;
typedef $$AyahsTableCreateCompanionBuilder =
    AyahsCompanion Function({
      Value<int> id,
      required int surahId,
      required int number,
      required String ayahText,
    });
typedef $$AyahsTableUpdateCompanionBuilder =
    AyahsCompanion Function({
      Value<int> id,
      Value<int> surahId,
      Value<int> number,
      Value<String> ayahText,
    });

final class $$AyahsTableReferences
    extends BaseReferences<_$AppDatabase, $AyahsTable, Ayah> {
  $$AyahsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SurahsTable _surahIdTable(_$AppDatabase db) => db.surahs.createAlias(
    $_aliasNameGenerator(db.ayahs.surahId, db.surahs.id),
  );

  $$SurahsTableProcessedTableManager get surahId {
    final $_column = $_itemColumn<int>('surah_id')!;

    final manager = $$SurahsTableTableManager(
      $_db,
      $_db.surahs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_surahIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AyahsTableFilterComposer extends Composer<_$AppDatabase, $AyahsTable> {
  $$AyahsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ayahText => $composableBuilder(
    column: $table.ayahText,
    builder: (column) => ColumnFilters(column),
  );

  $$SurahsTableFilterComposer get surahId {
    final $$SurahsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableFilterComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahsTableOrderingComposer
    extends Composer<_$AppDatabase, $AyahsTable> {
  $$AyahsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ayahText => $composableBuilder(
    column: $table.ayahText,
    builder: (column) => ColumnOrderings(column),
  );

  $$SurahsTableOrderingComposer get surahId {
    final $$SurahsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableOrderingComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AyahsTable> {
  $$AyahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get ayahText =>
      $composableBuilder(column: $table.ayahText, builder: (column) => column);

  $$SurahsTableAnnotationComposer get surahId {
    final $$SurahsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahId,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableAnnotationComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AyahsTable,
          Ayah,
          $$AyahsTableFilterComposer,
          $$AyahsTableOrderingComposer,
          $$AyahsTableAnnotationComposer,
          $$AyahsTableCreateCompanionBuilder,
          $$AyahsTableUpdateCompanionBuilder,
          (Ayah, $$AyahsTableReferences),
          Ayah,
          PrefetchHooks Function({bool surahId})
        > {
  $$AyahsTableTableManager(_$AppDatabase db, $AyahsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AyahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AyahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$AyahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> surahId = const Value.absent(),
                Value<int> number = const Value.absent(),
                Value<String> ayahText = const Value.absent(),
              }) => AyahsCompanion(
                id: id,
                surahId: surahId,
                number: number,
                ayahText: ayahText,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int surahId,
                required int number,
                required String ayahText,
              }) => AyahsCompanion.insert(
                id: id,
                surahId: surahId,
                number: number,
                ayahText: ayahText,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$AyahsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({surahId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (surahId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.surahId,
                            referencedTable: $$AyahsTableReferences
                                ._surahIdTable(db),
                            referencedColumn:
                                $$AyahsTableReferences._surahIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AyahsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AyahsTable,
      Ayah,
      $$AyahsTableFilterComposer,
      $$AyahsTableOrderingComposer,
      $$AyahsTableAnnotationComposer,
      $$AyahsTableCreateCompanionBuilder,
      $$AyahsTableUpdateCompanionBuilder,
      (Ayah, $$AyahsTableReferences),
      Ayah,
      PrefetchHooks Function({bool surahId})
    >;
typedef $$HadithsTableCreateCompanionBuilder =
    HadithsCompanion Function({
      Value<int> id,
      required String book,
      Value<String?> chapter,
      required String hadithText,
    });
typedef $$HadithsTableUpdateCompanionBuilder =
    HadithsCompanion Function({
      Value<int> id,
      Value<String> book,
      Value<String?> chapter,
      Value<String> hadithText,
    });

class $$HadithsTableFilterComposer
    extends Composer<_$AppDatabase, $HadithsTable> {
  $$HadithsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get book => $composableBuilder(
    column: $table.book,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hadithText => $composableBuilder(
    column: $table.hadithText,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HadithsTableOrderingComposer
    extends Composer<_$AppDatabase, $HadithsTable> {
  $$HadithsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get book => $composableBuilder(
    column: $table.book,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chapter => $composableBuilder(
    column: $table.chapter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hadithText => $composableBuilder(
    column: $table.hadithText,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HadithsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HadithsTable> {
  $$HadithsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get book =>
      $composableBuilder(column: $table.book, builder: (column) => column);

  GeneratedColumn<String> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<String> get hadithText => $composableBuilder(
    column: $table.hadithText,
    builder: (column) => column,
  );
}

class $$HadithsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HadithsTable,
          Hadith,
          $$HadithsTableFilterComposer,
          $$HadithsTableOrderingComposer,
          $$HadithsTableAnnotationComposer,
          $$HadithsTableCreateCompanionBuilder,
          $$HadithsTableUpdateCompanionBuilder,
          (Hadith, BaseReferences<_$AppDatabase, $HadithsTable, Hadith>),
          Hadith,
          PrefetchHooks Function()
        > {
  $$HadithsTableTableManager(_$AppDatabase db, $HadithsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$HadithsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$HadithsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$HadithsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> book = const Value.absent(),
                Value<String?> chapter = const Value.absent(),
                Value<String> hadithText = const Value.absent(),
              }) => HadithsCompanion(
                id: id,
                book: book,
                chapter: chapter,
                hadithText: hadithText,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String book,
                Value<String?> chapter = const Value.absent(),
                required String hadithText,
              }) => HadithsCompanion.insert(
                id: id,
                book: book,
                chapter: chapter,
                hadithText: hadithText,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HadithsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HadithsTable,
      Hadith,
      $$HadithsTableFilterComposer,
      $$HadithsTableOrderingComposer,
      $$HadithsTableAnnotationComposer,
      $$HadithsTableCreateCompanionBuilder,
      $$HadithsTableUpdateCompanionBuilder,
      (Hadith, BaseReferences<_$AppDatabase, $HadithsTable, Hadith>),
      Hadith,
      PrefetchHooks Function()
    >;
typedef $$TasbihSessionsTableCreateCompanionBuilder =
    TasbihSessionsCompanion Function({
      Value<int> id,
      Value<String?> name,
      Value<int> count,
    });
typedef $$TasbihSessionsTableUpdateCompanionBuilder =
    TasbihSessionsCompanion Function({
      Value<int> id,
      Value<String?> name,
      Value<int> count,
    });

class $$TasbihSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $TasbihSessionsTable> {
  $$TasbihSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TasbihSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TasbihSessionsTable> {
  $$TasbihSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasbihSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasbihSessionsTable> {
  $$TasbihSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);
}

class $$TasbihSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasbihSessionsTable,
          TasbihSession,
          $$TasbihSessionsTableFilterComposer,
          $$TasbihSessionsTableOrderingComposer,
          $$TasbihSessionsTableAnnotationComposer,
          $$TasbihSessionsTableCreateCompanionBuilder,
          $$TasbihSessionsTableUpdateCompanionBuilder,
          (
            TasbihSession,
            BaseReferences<_$AppDatabase, $TasbihSessionsTable, TasbihSession>,
          ),
          TasbihSession,
          PrefetchHooks Function()
        > {
  $$TasbihSessionsTableTableManager(
    _$AppDatabase db,
    $TasbihSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TasbihSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$TasbihSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$TasbihSessionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<int> count = const Value.absent(),
              }) => TasbihSessionsCompanion(id: id, name: name, count: count),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<int> count = const Value.absent(),
              }) => TasbihSessionsCompanion.insert(
                id: id,
                name: name,
                count: count,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasbihSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasbihSessionsTable,
      TasbihSession,
      $$TasbihSessionsTableFilterComposer,
      $$TasbihSessionsTableOrderingComposer,
      $$TasbihSessionsTableAnnotationComposer,
      $$TasbihSessionsTableCreateCompanionBuilder,
      $$TasbihSessionsTableUpdateCompanionBuilder,
      (
        TasbihSession,
        BaseReferences<_$AppDatabase, $TasbihSessionsTable, TasbihSession>,
      ),
      TasbihSession,
      PrefetchHooks Function()
    >;
typedef $$PrayerTimesTableCreateCompanionBuilder =
    PrayerTimesCompanion Function({
      Value<int> id,
      required DateTime date,
      required int fajr,
      required int dhuhr,
      required int asr,
      required int maghrib,
      required int isha,
    });
typedef $$PrayerTimesTableUpdateCompanionBuilder =
    PrayerTimesCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<int> fajr,
      Value<int> dhuhr,
      Value<int> asr,
      Value<int> maghrib,
      Value<int> isha,
    });

class $$PrayerTimesTableFilterComposer
    extends Composer<_$AppDatabase, $PrayerTimesTable> {
  $$PrayerTimesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fajr => $composableBuilder(
    column: $table.fajr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dhuhr => $composableBuilder(
    column: $table.dhuhr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get asr => $composableBuilder(
    column: $table.asr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maghrib => $composableBuilder(
    column: $table.maghrib,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isha => $composableBuilder(
    column: $table.isha,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PrayerTimesTableOrderingComposer
    extends Composer<_$AppDatabase, $PrayerTimesTable> {
  $$PrayerTimesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fajr => $composableBuilder(
    column: $table.fajr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dhuhr => $composableBuilder(
    column: $table.dhuhr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get asr => $composableBuilder(
    column: $table.asr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maghrib => $composableBuilder(
    column: $table.maghrib,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isha => $composableBuilder(
    column: $table.isha,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PrayerTimesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PrayerTimesTable> {
  $$PrayerTimesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get fajr =>
      $composableBuilder(column: $table.fajr, builder: (column) => column);

  GeneratedColumn<int> get dhuhr =>
      $composableBuilder(column: $table.dhuhr, builder: (column) => column);

  GeneratedColumn<int> get asr =>
      $composableBuilder(column: $table.asr, builder: (column) => column);

  GeneratedColumn<int> get maghrib =>
      $composableBuilder(column: $table.maghrib, builder: (column) => column);

  GeneratedColumn<int> get isha =>
      $composableBuilder(column: $table.isha, builder: (column) => column);
}

class $$PrayerTimesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PrayerTimesTable,
          PrayerTime,
          $$PrayerTimesTableFilterComposer,
          $$PrayerTimesTableOrderingComposer,
          $$PrayerTimesTableAnnotationComposer,
          $$PrayerTimesTableCreateCompanionBuilder,
          $$PrayerTimesTableUpdateCompanionBuilder,
          (
            PrayerTime,
            BaseReferences<_$AppDatabase, $PrayerTimesTable, PrayerTime>,
          ),
          PrayerTime,
          PrefetchHooks Function()
        > {
  $$PrayerTimesTableTableManager(_$AppDatabase db, $PrayerTimesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PrayerTimesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PrayerTimesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$PrayerTimesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> fajr = const Value.absent(),
                Value<int> dhuhr = const Value.absent(),
                Value<int> asr = const Value.absent(),
                Value<int> maghrib = const Value.absent(),
                Value<int> isha = const Value.absent(),
              }) => PrayerTimesCompanion(
                id: id,
                date: date,
                fajr: fajr,
                dhuhr: dhuhr,
                asr: asr,
                maghrib: maghrib,
                isha: isha,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required int fajr,
                required int dhuhr,
                required int asr,
                required int maghrib,
                required int isha,
              }) => PrayerTimesCompanion.insert(
                id: id,
                date: date,
                fajr: fajr,
                dhuhr: dhuhr,
                asr: asr,
                maghrib: maghrib,
                isha: isha,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PrayerTimesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PrayerTimesTable,
      PrayerTime,
      $$PrayerTimesTableFilterComposer,
      $$PrayerTimesTableOrderingComposer,
      $$PrayerTimesTableAnnotationComposer,
      $$PrayerTimesTableCreateCompanionBuilder,
      $$PrayerTimesTableUpdateCompanionBuilder,
      (
        PrayerTime,
        BaseReferences<_$AppDatabase, $PrayerTimesTable, PrayerTime>,
      ),
      PrayerTime,
      PrefetchHooks Function()
    >;
typedef $$DonationsTableCreateCompanionBuilder =
    DonationsCompanion Function({
      Value<int> id,
      required double amount,
      Value<DateTime> date,
      required String charityName,
    });
typedef $$DonationsTableUpdateCompanionBuilder =
    DonationsCompanion Function({
      Value<int> id,
      Value<double> amount,
      Value<DateTime> date,
      Value<String> charityName,
    });

class $$DonationsTableFilterComposer
    extends Composer<_$AppDatabase, $DonationsTable> {
  $$DonationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get charityName => $composableBuilder(
    column: $table.charityName,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DonationsTableOrderingComposer
    extends Composer<_$AppDatabase, $DonationsTable> {
  $$DonationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get charityName => $composableBuilder(
    column: $table.charityName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DonationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DonationsTable> {
  $$DonationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get charityName => $composableBuilder(
    column: $table.charityName,
    builder: (column) => column,
  );
}

class $$DonationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DonationsTable,
          Donation,
          $$DonationsTableFilterComposer,
          $$DonationsTableOrderingComposer,
          $$DonationsTableAnnotationComposer,
          $$DonationsTableCreateCompanionBuilder,
          $$DonationsTableUpdateCompanionBuilder,
          (Donation, BaseReferences<_$AppDatabase, $DonationsTable, Donation>),
          Donation,
          PrefetchHooks Function()
        > {
  $$DonationsTableTableManager(_$AppDatabase db, $DonationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DonationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DonationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$DonationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> charityName = const Value.absent(),
              }) => DonationsCompanion(
                id: id,
                amount: amount,
                date: date,
                charityName: charityName,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double amount,
                Value<DateTime> date = const Value.absent(),
                required String charityName,
              }) => DonationsCompanion.insert(
                id: id,
                amount: amount,
                date: date,
                charityName: charityName,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DonationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DonationsTable,
      Donation,
      $$DonationsTableFilterComposer,
      $$DonationsTableOrderingComposer,
      $$DonationsTableAnnotationComposer,
      $$DonationsTableCreateCompanionBuilder,
      $$DonationsTableUpdateCompanionBuilder,
      (Donation, BaseReferences<_$AppDatabase, $DonationsTable, Donation>),
      Donation,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SurahsTableTableManager get surahs =>
      $$SurahsTableTableManager(_db, _db.surahs);
  $$AyahsTableTableManager get ayahs =>
      $$AyahsTableTableManager(_db, _db.ayahs);
  $$HadithsTableTableManager get hadiths =>
      $$HadithsTableTableManager(_db, _db.hadiths);
  $$TasbihSessionsTableTableManager get tasbihSessions =>
      $$TasbihSessionsTableTableManager(_db, _db.tasbihSessions);
  $$PrayerTimesTableTableManager get prayerTimes =>
      $$PrayerTimesTableTableManager(_db, _db.prayerTimes);
  $$DonationsTableTableManager get donations =>
      $$DonationsTableTableManager(_db, _db.donations);
}
