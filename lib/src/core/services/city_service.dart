import 'dart:convert';

import 'package:http/http.dart' as http;

class CityService {
  final http.Client client;
  CityService({http.Client? client}) : client = client ?? http.Client();

  Future<List<String>> fetchCountries() async {
    final uri = Uri.parse('https://countriesnow.space/api/v0.1/countries');
    final response = await client.get(uri);
    if (response.statusCode != 200) {
      return const ['Qatar', 'Kazakhstan', 'Turkey', 'Uzbekistan'];
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final list = (data['data'] as List)
        .map((e) => e['country'] as String)
        .toList();
    list.sort();
    return list;
  }

  Future<List<String>> fetchCities(String country) async {
    final uri =
        Uri.parse('https://countriesnow.space/api/v0.1/countries/cities');
    final response = await client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'country': country}),
    );
    if (response.statusCode != 200) {
      return const ['Doha', 'Istanbul', 'Almaty', 'Tashkent'];
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final list = (data['data'] as List).cast<String>();
    list.sort();
    return list;
  }
}
