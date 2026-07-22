import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/search_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(),
        const SizedBox(height: 20),
        SearchBarWidget(
          onCitySelected: (lat, lon, name) {
            debugPrint("Ciudad seleccionada: $name -> Lat: $lat, Lon: $lon");
          },
        ),
      ],
    );
  }
}
