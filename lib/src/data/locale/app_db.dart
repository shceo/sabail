// import 'dart:io';
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:path_provider/path_provider.dart';

// part 'app_database.g.dart';

// // Таблицы приложения
// class Surahs extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get name => text()();
//   TextColumn get arabicText => text()();
//   TextColumn get translation => text().nullable()();
// }

// class Ayahs extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   IntColumn get surahId => integer().references(Surahs, #id)();
//   IntColumn get number => integer()();
//   TextColumn get text => text()();
// }

// class Hadiths extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get book => text()();
//   TextColumn get chapter => text().nullable()();
//   TextColumn get text => text()();
// }

// class TasbihSessions extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get name => text().nullable()();
//   IntColumn get count => integer().withDefault(const Constant(0))();
// }

// class PrayerTimes extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   DateTimeColumn get date => dateTime()();
//   IntColumn get fajr => integer()();
//   IntColumn get dhuhr => integer()();
//   IntColumn get asr => integer()();
//   IntColumn get maghrib => integer()();
//   IntColumn get isha => integer()();
// }

// class Donations extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   RealColumn get amount => real()();
//   DateTimeColumn get date => dateTime().clientDefault(() => DateTime.now())();
//   TextColumn get charityName => text()();
// }

// @DriftDatabase(
//   tables: [
//     Surahs,
//     Ayahs,
//     Hadiths,
//     TasbihSessions,
//     PrayerTimes,
//     Donations,
//   ],
// )
// class AppDatabase extends _$AppDatabase {
//   AppDatabase._(QueryExecutor e) : super(e);

//   /// Инициализатор, открывающий файл в каталоге приложения
//   factory AppDatabase.open() {
//     final dbFolder = getApplicationDocumentsDirectory();
//     return AppDatabase._(
//       LazyDatabase(() async {
//         final dir = await dbFolder;
//         final file = File('${dir.path}/app_database.sqlite');
//         return NativeDatabase(file);
//       }),
//     );
//   }

//   @override
//   int get schemaVersion => 1;

//   @override
//   MigrationStrategy get migration => MigrationStrategy(
//         onCreate: (m) async {
//           await m.createAll();
//         },
//         onUpgrade: (m, from, to) async {
//           // TODO: реализовать миграции при изменении схемы
//         },
//       );

//   // Примеры запросов
//   Future<List<Surah>> getAllSurahs() => select(surahs).get();
//   Future<int> insertSurah(Insertable<Surah> surah) => into(surahs).insert(surah);

//   Stream<List<Ayah>> watchAyahsBySurah(int surahId) {
//     return (select(ayahs)..where((tbl) => tbl.surahId.equals(surahId))).watch();
//   }

//   Future<int> insertHadith(Insertable<Hadith> hadith) => into(hadiths).insert(hadith);
//   Future<List<Hadith>> getRecentHadiths() => (select(hadiths)..orderBy([(t) => OrderingTerm.desc(t.id)])).get();

//   Future<int> startTasbihSession(String? name) => into(tasbihSessions).insert(TasbihSessionsCompanion(name: Value(name)));
//   Future<int> updateTasbihCount(int id, int count) => (update(tasbihSessions)..where((t) => t.id.equals(id))).write(TasbihSessionsCompanion(count: Value(count)));

//   Future<int> insertPrayerTimes(Insertable<PrayerTime> pt) => into(prayerTimes).insert(pt);
//   Future<List<PrayerTime>> getPrayerTimesByDate(DateTime date) => (select(prayerTimes)..where((t) => t.date.equals(date))).get();

//   Future<int> insertDonation(Insertable<Donation> donation) => into(donations).insert(donation);
//   Future<List<Donation>> getAllDonations() => select(donations).get();
// }
