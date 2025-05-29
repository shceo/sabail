import 'package:drift/drift.dart';
import 'db.dart';  // импорт AppDatabase и definitions таблиц

part 'city_dao.g.dart';

@DriftAccessor(tables: [Cities])
class CityDao extends DatabaseAccessor<AppDatabase> with _$CityDaoMixin {
  CityDao(AppDatabase db) : super(db);

  /// Вернуть все города (имена) в алфавитном порядке
  Future<List<CityEntity>> getAllCities() {
    return (select(cities)
          ..orderBy([(c) => OrderingTerm(expression: c.name)]))
        .get();
  }

  /// Вернуть последний добавленный город
  Future<CityEntity?> getLastCity() {
    return (select(cities)
          ..orderBy([(c) => OrderingTerm.desc(c.id)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Вставить один город
  Future<int> insertCity(CitiesCompanion entry) {
    return into(cities).insert(entry, mode: InsertMode.insertOrIgnore);
  }

  /// Вставить сразу список городов (insert or ignore)
  Future<void> insertCities(List<String> names) async {
    await batch((b) {
      b.insertAll(
        cities,
        names.map((n) => CitiesCompanion.insert(name: n)).toList(),
        mode: InsertMode.insertOrIgnore,
      );
    });
  }
}
