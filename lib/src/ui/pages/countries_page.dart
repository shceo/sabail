import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabail/src/provider/user_city.dart';
import 'package:sabail/src/ui/theme/app_colors.dart';

class CitiesAndCountriesPage extends StatelessWidget {
  const CitiesAndCountriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Получаем глобальный CityProvider из контекста
    final cityProvider = Provider.of<CityProvider>(context, listen: false);
    
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Введите название города',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                cityProvider.updateSearchQuery(query);
              },
            ),
          ),
          // Используем Consumer для отслеживания изменений
          Expanded(
            child: Consumer<CityProvider>(
              builder: (context, cityProvider, child) {
                final filteredCities = cityProvider.getFilteredCityNames();
                // Если список городов ещё не загружен, можно показать лоадер
                if (filteredCities.isEmpty) {
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
                return ListView.builder(
                  itemCount: filteredCities.length,
                  itemBuilder: (context, index) {
                    final city = filteredCities[index];
                    return ListTile(
                      title: Text(city),
                      onTap: () {
                        cityProvider.updateSelectedCity(city);
                        Navigator.pop(context);
                      },
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
