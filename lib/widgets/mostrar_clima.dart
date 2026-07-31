import 'package:flutter/material.dart';
import 'detalle_container.dart';
import 'header.dart';
import '../models/weather_data.dart';
import 'search_bar.dart';
import 'hourly_forecast_carousel.dart';
import '../models/weather_location.dart';

class MostrarClima extends StatelessWidget {
  const MostrarClima({required this.weatherData, required this.location, super.key});

  final WeatherData weatherData;
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
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      top: 79,
                      child: DetalleContainer(location: location),
                    ),
                    Positioned.fill(
                      child: SearchBarWidget(
                        initialText: location.label,
                        replaceCurrentRoute: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
