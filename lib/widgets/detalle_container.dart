import 'package:flutter/material.dart';

import '../models/weather_card_data.dart';
import 'detalle.dart';

class DetalleContainer extends StatefulWidget {
  const DetalleContainer({super.key});

  @override
  State<DetalleContainer> createState() => _DetalleContainerState();
}

class _DetalleContainerState extends State<DetalleContainer> {
  List<WeatherCardData> data = [];

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    try {
      final cards = await fetchWeatherData();

      if (!mounted) return;

      setState(() {
        data = cards;
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

    return Detalle(data: data);
  }
}
