import 'package:flutter/material.dart';
import '../models/weather_data.dart';
import '../models/weather_location.dart';
import 'mostrar_clima.dart';

class MostrarClimaContainer extends StatefulWidget {
  const MostrarClimaContainer({required this.location, super.key});

  final WeatherLocation location;

  @override
  State<MostrarClimaContainer> createState() => _MostrarClimaContainerState();
}

class _MostrarClimaContainerState extends State<MostrarClimaContainer> {
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

    return MostrarClima(weatherData: weatherData!, location: location);
  }
}
