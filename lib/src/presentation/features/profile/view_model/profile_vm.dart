import 'package:flutter/material.dart';
import '../../../../domain/entities/city.dart';
import '../../../../domain/usecases/get_city_usecase.dart';

class ProfileViewModel extends ChangeNotifier {
  final GetCityUseCase _getCity;
  City? city;
  bool isLoading = false;
  String? error;

  ProfileViewModel({ required GetCityUseCase getCity }) : _getCity = getCity;

  Future<void> loadCity() async {
    isLoading = true; notifyListeners();
    try {
      city = await _getCity.execute();
    } catch (e) {
      error = e.toString();
    }
    isLoading = false; notifyListeners();
  }
}
