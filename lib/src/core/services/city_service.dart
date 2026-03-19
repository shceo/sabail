import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class CityService {
  static const Duration _requestTimeout = Duration(seconds: 10);
  static const List<String> _fallbackCountries = [
    'Kazakhstan',
    'Qatar',
    'Turkey',
    'Uzbekistan',
  ];
  static const Map<String, List<String>> _fallbackCitiesByCountry = {
    'kazakhstan': ['Almaty', 'Astana', 'Shymkent'],
    'qatar': ['Doha'],
    'turkey': ['Ankara', 'Istanbul', 'Izmir'],
    'uzbekistan': ['Bukhara', 'Namangan', 'Samarkand', 'Tashkent'],
  };

  final http.Client client;

  CityService({http.Client? client}) : client = client ?? http.Client();

  Future<List<String>> fetchCountries() async {
    final uri = Uri.parse('https://countriesnow.space/api/v0.1/countries');

    try {
      final response = await client.get(uri).timeout(_requestTimeout);
      if (response.statusCode != 200) {
        return _sortedCopy(_fallbackCountries);
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final list = (data['data'] as List)
          .map((e) => e['country'] as String)
          .toList();
      if (list.isEmpty) {
        return _sortedCopy(_fallbackCountries);
      }

      list.sort();
      return list;
    } catch (_) {
      return _sortedCopy(_fallbackCountries);
    }
  }

  Future<List<String>> fetchCities(String country) async {
    final uri =
        Uri.parse('https://countriesnow.space/api/v0.1/countries/cities');

    try {
      final response = await client
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'country': country}),
          )
          .timeout(_requestTimeout);
      if (response.statusCode != 200) {
        return _fallbackCities(country);
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final list = (data['data'] as List).cast<String>();
      if (list.isEmpty) {
        return _fallbackCities(country);
      }

      list.sort();
      return list;
    } catch (_) {
      return _fallbackCities(country);
    }
  }

  List<String> _fallbackCities(String country) {
    final fallback = _fallbackCitiesByCountry[country.trim().toLowerCase()];
    if (fallback == null) {
      return const [];
    }
    return _sortedCopy(fallback);
  }

  List<String> _sortedCopy(List<String> values) {
    final copy = List<String>.from(values);
    copy.sort();
    return copy;
  }
}
