import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/weather_location.dart';

class WeatherCardData {
  const WeatherCardData({
    required this.title,
    required this.metric,
    required this.caption,
    required this.icon,
    required this.iconBackground,
    required this.cardBackground,
    required this.cardBorderColor,
    this.captionColor,
  });

  final String title;
  final String metric;
  final String caption;
  final IconData icon;
  final Color iconBackground;
  final Color cardBackground;
  final Color cardBorderColor;
  final Color? captionColor;
}

Future<List<WeatherCardData>> fetchWeatherData(WeatherLocation location) async {
  final uri = Uri.parse(
    'https://api.open-meteo.com/v1/forecast?latitude=${location.latitude}&longitude=${location.longitude}&hourly=temperature_2m,weather_code&current=temperature_2m,apparent_temperature,is_day,rain,weather_code,cloud_cover,pressure_msl,wind_speed_10m,wind_direction_10m,wind_gusts_10m,precipitation,relative_humidity_2m,uv_index&timezone=auto&forecast_days=1',
  );

  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Request failed with status ${response.statusCode}');
  }

  final responseData = jsonDecode(response.body);
  final current = responseData['current'];
  final currentUnits = responseData['current_units'];

  return [
    WeatherCardData(
      title: 'Humidity',
      metric:
          '${current['relative_humidity_2m']}'
          '${currentUnits['relative_humidity_2m']}',
      caption: 'Relative humidity',
      icon: Icons.water_drop_outlined,
      iconBackground: const Color(0xFF4DA3FF),
      cardBackground: const Color(0xFF29466D),
      cardBorderColor: const Color(0xFF3A5A83),
    ),
    WeatherCardData(
      title: 'UV index',
      metric: _formatNumber(current['uv_index']),
      caption: _getUvDescription((current['uv_index'] as num).toDouble()),
      icon: Icons.wb_sunny_outlined,
      iconBackground: const Color(0xFFE8D636),
      cardBackground: const Color(0xFF29466D),
      cardBorderColor: const Color(0xFF3A5A83),
      captionColor: _getUvColor((current['uv_index'] as num).toDouble()),
    ),
    WeatherCardData(
      title: 'Cloud cover',
      metric: '${current['cloud_cover']}${currentUnits['cloud_cover']}',
      caption: 'Sky coverage',
      icon: Icons.cloud_outlined,
      iconBackground: const Color(0xFF9EB2CC),
      cardBackground: const Color(0xFF29466D),
      cardBorderColor: const Color(0xFF3A5A83),
    ),
    WeatherCardData(
      title: 'Pressure',
      metric: _formatNumber(current['pressure_msl']),
      caption: currentUnits['pressure_msl'].toString(),
      icon: Icons.speed,
      iconBackground: const Color(0xFFB46DFF),
      cardBackground: const Color(0xFF29466D),
      cardBorderColor: const Color(0xFF3A5A83),
    ),
    WeatherCardData(
      title: 'Wind speed',
      metric: _formatNumber(current['wind_speed_10m']),
      caption: currentUnits['wind_speed_10m'].toString(),
      icon: Icons.air,
      iconBackground: const Color(0xFF20D7C5),
      cardBackground: const Color(0xFF29466D),
      cardBorderColor: const Color(0xFF3A5A83),
    ),
    WeatherCardData(
      title: 'Wind direction',
      metric: _windDirectionToCompass(
        (current['wind_direction_10m'] as num).toDouble(),
      ),
      caption:
          '${_formatNumber(current['wind_direction_10m'])}'
          '${currentUnits['wind_direction_10m']}',
      icon: Icons.navigation_outlined,
      iconBackground: const Color(0xFF31D6C9),
      cardBackground: const Color(0xFF29466D),
      cardBorderColor: const Color(0xFF3A5A83),
    ),
    WeatherCardData(
      title: 'Wind gusts',
      metric: _formatNumber(current['wind_gusts_10m']),
      caption: '${currentUnits['wind_gusts_10m']} peak',
      icon: Icons.air,
      iconBackground: const Color(0xFFF6A623),
      cardBackground: const Color(0xFF29466D),
      cardBorderColor: const Color(0xFF3A5A83),
    ),
    WeatherCardData(
      title: 'Precipitation',
      metric: _formatNumber(current['precipitation']),
      caption: '${currentUnits['precipitation']} / hr',
      icon: Icons.umbrella_outlined,
      iconBackground: const Color(0xFF75B9FF),
      cardBackground: const Color(0xFF29466D),
      cardBorderColor: const Color(0xFF3A5A83),
    ),
  ];
}

String _formatNumber(dynamic value) {
  if (value is! num) {
    //to evade numeric conversion errors
    return value.toString();
  }

  if (value % 1 == 0) {
    //if it is an integer, convert directly to string without any transformation
    return value.toInt().toString();
  }

  return value.toStringAsFixed(1); // truncate the real number to one decimal place
}

String _windDirectionToCompass(double degrees) {
  const directions = [
    'N',
    'NNE',
    'NE',
    'ENE',
    'E',
    'ESE',
    'SE',
    'SSE',
    'S',
    'SSW',
    'SW',
    'WSW',
    'W',
    'WNW',
    'NW',
    'NNW',
  ];

  final normalizedDegrees = degrees % 360;
  final index = ((normalizedDegrees + 11.25) / 22.5).floor() % 16;

  return directions[index];
}

String _getUvDescription(double uvIndex) {
  if (uvIndex < 3) return 'Low';
  if (uvIndex < 6) return 'Moderate';
  if (uvIndex < 8) return 'High';
  if (uvIndex < 11) return 'Very high';
  return 'Extreme';
}

Color _getUvColor(double uvIndex) {
  if (uvIndex < 3) return const Color(0xFF41E08D);
  if (uvIndex < 6) return const Color(0xFFFFD54F);
  if (uvIndex < 8) return const Color(0xFFFFA726);
  if (uvIndex < 11) return const Color(0xFFFF5C8A);
  return const Color(0xFFB46DFF);
}
