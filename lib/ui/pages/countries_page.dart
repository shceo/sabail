import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sabail/provider/user_city.dart';
import 'package:sabail/ui/theme/app_colors.dart';

class CitiesAndCountriesPage extends StatelessWidget {
  const CitiesAndCountriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CityProvider(),
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Ваше местоположение',
              style: TextStyle(fontFamily: GoogleFonts.oswald().fontFamily),
            ),
            centerTitle: true),
        body: FutureBuilder(
          future: Provider.of<CityProvider>(context, listen: false).initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
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
                        Provider.of<CityProvider>(context, listen: false)
                            .updateSearchQuery(query);
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<CityProvider>(
                      builder: (context, cityProvider, child) {
                        return ListView(
                          children:
                              cityProvider.getFilteredCityNames().map((city) {
                            return ListTile(
                              title: Text(city),
                              onTap: () {
                                cityProvider.updateSelectedCity(city);
                                Navigator.pop(context);
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
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
          },
        ),
      ),
    );
  }
}
