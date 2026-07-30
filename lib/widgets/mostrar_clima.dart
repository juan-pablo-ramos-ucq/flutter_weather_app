import 'package:flutter/material.dart';
import 'detalle_container.dart';
import 'header.dart';
import '../models/weather_location.dart';
import 'search_bar.dart';

class MostrarClima extends StatelessWidget {
  const MostrarClima({required this.location, super.key});

  final WeatherLocation location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              const SizedBox(height: 23),
              SearchBarWidget(),
              const SizedBox(height: 23),
              Expanded(child: DetalleContainer(location: location)),
            ],
          ),
        ),
      ),
    );
  }
}
