import '../entities/city.dart';
import '../repositories/city_repository.dart';

class GetCityUseCase {
  final CityRepository _repo;
  GetCityUseCase(this._repo);

  Future<City?> execute() {
    return _repo.getSavedCity();
  }
}
