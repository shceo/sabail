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
  late final $TasbihSessionsTable tasbihSessions = $TasbihSessionsTable(this);
  late final $PrayerTimesTable prayerTimes = $PrayerTimesTable(this);
  late final $DonationsTable donations = $DonationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    surahs,
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
          (Surah, BaseReferences<_$AppDatabase, $SurahsTable, Surah>),
          Surah,
          PrefetchHooks Function()
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
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
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
      (Surah, BaseReferences<_$AppDatabase, $SurahsTable, Surah>),
      Surah,
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
  $$TasbihSessionsTableTableManager get tasbihSessions =>
      $$TasbihSessionsTableTableManager(_db, _db.tasbihSessions);
  $$PrayerTimesTableTableManager get prayerTimes =>
      $$PrayerTimesTableTableManager(_db, _db.prayerTimes);
  $$DonationsTableTableManager get donations =>
      $$DonationsTableTableManager(_db, _db.donations);
}
