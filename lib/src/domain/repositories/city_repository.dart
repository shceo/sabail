import '../entities/city.dart';

abstract class CityRepository {
  Future<City?> getSavedCity();
  Future<void> saveCity(City city);
}
