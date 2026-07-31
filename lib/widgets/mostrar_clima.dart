import 'package:flutter/material.dart';
import 'detalle_grid.dart';
import 'header.dart';
import '../models/weather_data.dart';
import 'search_bar.dart';
import 'hourly_forecast_carousel.dart';
import '../models/weather_location.dart';

class MostrarClima extends StatelessWidget {
  const MostrarClima({
    required this.weatherData,
    required this.location,
    super.key,
  });

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
                      bottom: 109,
                      child: DetalleGrid(data: weatherData.currentCards),
                    ),
                    Positioned.fill(
                      child: SearchBarWidget(
                        initialText: location.label,
                        replaceCurrentRoute: true,
                      ),
                    ),
                    Positioned(
                      // it is basically Positioned.fill with top equal to auto
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: HourlyForecastCarousel(
                        forecasts: weatherData.hourlyForecast,
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
