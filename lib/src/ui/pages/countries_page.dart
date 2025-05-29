// lib/src/presentation/features/home/view/cities_and_countries_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sabail/src/data/locale/db.dart';
import 'package:sabail/src/presentation/app/injector.dart';
import 'package:sabail/src/presentation/app/app_colors.dart';

class CitiesAndCountriesPage extends StatefulWidget {
  const CitiesAndCountriesPage({Key? key}) : super(key: key);

  @override
  _CitiesAndCountriesPageState createState() => _CitiesAndCountriesPageState();
}

class _CitiesAndCountriesPageState extends State<CitiesAndCountriesPage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Получаем инстанс базы из GetIt
    final db = sl<AppDatabase>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ваше местоположение',
          style: TextStyle(fontFamily: GoogleFonts.oswald().fontFamily),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Поисковая строка
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Введите название города',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                setState(() {
                  _searchQuery = query.toLowerCase();
                });
              },
            ),
          ),

          // Список городов
          Expanded(
            child: FutureBuilder<List<String>>(
              future: db.getAllCities(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitCircle(color: SabailColors.lightpurple),
                        const SizedBox(height: 20),
                        const Text('Загружаюсь...'),
                      ],
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Ошибка: ${snapshot.error}'),
                  );
                }

                // У нас есть список всех городов
                final allCities = snapshot.data!;
                // Фильтруем по запросу
                final filtered = _searchQuery.isEmpty
                    ? allCities
                    : allCities
                        .where((c) => c.toLowerCase().contains(_searchQuery))
                        .toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text('Город не найден'));
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (_, index) {
                    final city = filtered[index];
                    return ListTile(
                      title: Text(city),
                      onTap: () => Navigator.pop(context, city),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
