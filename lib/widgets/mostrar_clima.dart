import 'package:flutter/material.dart';
import 'detalle_grid.dart';
import 'header.dart';
import '../models/weather_data.dart';
import 'search_bar_container.dart';
import 'hourly_forecast_carousel.dart';
import '../models/weather_location.dart';
import './summary.dart';

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              const SizedBox(height: 23), // to separate aesthetically the header (i.e., logo and avatar) from the search bar 
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      const SizedBox(height: 64), // Reserves the occupied search bar space.
                      const SizedBox(height: 38), // to separate aesthetically the search bar from summary
                      Summary(summary: weatherData.currentSummary),
                      const SizedBox(height: 38), // to separate aesthetically the summary from detalle grid
                      DetalleGrid(data: weatherData.currentCards),
                      const SizedBox(height: 24), // to separete the detalle grid from forecast carousel
                      HourlyForecastCarousel(
                        forecasts: weatherData.hourlyForecast,
                      ),
                    ],
                  ),

                  // Fills the content area so its results can appear over the grid.
                  Positioned.fill(
                    child: SearchBarContainer(
                      initialText: location.label,
                      replaceCurrentRoute: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
