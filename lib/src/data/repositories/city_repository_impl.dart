import 'package:sabail/src/data/locale/city_dao.dart';
import 'package:sabail/src/data/locale/db.dart';
import '../../domain/entities/city.dart';
import '../../domain/repositories/city_repository.dart';

class CityRepositoryImpl implements CityRepository {
  final CityDao _dao;
  CityRepositoryImpl(this._dao);

  @override
  Future<City?> getSavedCity() async {
    final row = await _dao.getLastCity();
    return row == null ? null : City(id: row.id, name: row.name);
  }

  @override
  Future<void> saveCity(City city) {
    return _dao.insertCity(CitiesCompanion.insert(name: city.name));
  }
}
