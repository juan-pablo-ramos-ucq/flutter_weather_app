import 'package:flutter/material.dart';

import '../models/weather_card_data.dart';
import '../models/weather_location.dart';
import 'detalle.dart';
import 'hourly_forecast_carousel.dart';

class DetalleContainer extends StatefulWidget {
  const DetalleContainer({required this.location, super.key});

  final WeatherLocation location;

  @override
  State<DetalleContainer> createState() {
    return _DetalleContainerState();
  }
}

class _DetalleContainerState extends State<DetalleContainer> {
  WeatherData? weatherData;

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    try {
      final result = await fetchWeatherData(widget.location);

      if (!mounted) return;

      setState(() {
        weatherData = result;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Text(
          'Could not load weather data.\n$errorMessage',
          textAlign: TextAlign.center,
        ),
      );
    }

    final result = weatherData!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HourlyForecastCarousel(forecasts: result.hourlyForecast),
        const SizedBox(height: 20),
        Expanded(child: Detalle(data: result.currentCards)),
      ],
    );
  }
}
