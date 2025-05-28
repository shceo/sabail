// lib/src/db.dart

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'db.g.dart';

@DataClassName('Setting')
class Settings extends Table {
  IntColumn   get id    => integer().autoIncrement()();
  TextColumn  get key   => text().withLength(min: 1, max: 50)();
  TextColumn  get value => text()();
}

@DataClassName('ImageEntity')
class Images extends Table {
  IntColumn     get id        => integer().autoIncrement()();
  TextColumn    get path      => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('CityEntity')
class Cities extends Table {
  IntColumn  get id   => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
}

@DriftDatabase(tables: [Settings, Images, Cities])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Обёртки для Settings
  Future<String?> getSetting(String key) async {
    final query = select(settings)..where((tbl) => tbl.key.equals(key));
    final row = await query.getSingleOrNull();
    return row?.value;
  }
  Future<void> setSetting(String key, String value) async {
    into(settings).insertOnConflictUpdate(
      SettingsCompanion(key: Value(key), value: Value(value))
    );
  }

  // Обёртки для Images
  Future<String?> getLastImagePath() async {
    final query = (select(images)
      ..orderBy([(i) => OrderingTerm.desc(i.createdAt)])
      ..limit(1));
    final img = await query.getSingleOrNull();
    return img?.path;
  }
  Future<void> addImagePath(String path) =>
    into(images).insert(ImagesCompanion(path: Value(path)));

  // Обёртки для Cities
  Future<List<String>> getAllCities() async {
    final rows = await select(cities).get();
    return rows.map((r) => r.name).toList()..sort();
  }
  Future<void> insertCities(List<String> names) async {
    await batch((b) {
      b.insertAll(cities, names.map((n) => CitiesCompanion.insert(name: n)).toList(),
        mode: InsertMode.insertOrIgnore);
    });
  }
}

// Ленивая инициализация базы
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'app.sqlite'));
    return NativeDatabase(file);
  });
}
