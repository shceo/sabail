import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabail/src/provider/user_city.dart';
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
    // Здесь будем получать провайдера с ребилдом при изменениях
    final cityProvider = context.watch<CityProvider>();
    // Все города (загруженные из БД)
    final allCities = cityProvider.cityNames;
    // Отфильтрованный по _searchQuery
    final filteredCities = _searchQuery.isEmpty
        ? allCities
        : cityProvider.getFilteredCityNames(_searchQuery);

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
                  _searchQuery = query;
                });
              },
            ),
          ),

          Expanded(
            child: allCities.isEmpty
                // Ещё не подгрузились из БД — показываем спиннер
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitCircle(color: SabailColors.lightpurple),
                        const SizedBox(height: 20),
                        const Text('Загружаюсь...'),
                      ],
                    ),
                  )
                // Сами города уже есть — рисуем ListView
                : ListView.builder(
                    itemCount: filteredCities.length,
                    itemBuilder: (context, index) {
                      final city = filteredCities[index];
                      return ListTile(
                        title: Text(city),
                        onTap: () {
                          // Сохраняем выбор и выходим
                          cityProvider.updateSelectedCity(city);
                          Navigator.pop(context);
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
