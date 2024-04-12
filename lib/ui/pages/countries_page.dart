import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CitiesAndCountriesPage extends StatelessWidget {
  const CitiesAndCountriesPage({Key? key}) : super(key: key);

  Future<List<String>> getSuggestions(String query) async {
    final response = await rootBundle.loadString('assets/cities.json');
    final Map<String, dynamic> data = jsonDecode(response);
    final List<dynamic> citiesJson = data['city'];
    final List<String> cityNames = citiesJson.map((city) => city['name'] as String).toList();
    return cityNames.where((city) => city.startsWith(query)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Города и страны'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TypeAheadField<String?>(
                suggestionsCallback: getSuggestions,
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion!),
                  );
                },
                onSelected: (String? value) {  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
