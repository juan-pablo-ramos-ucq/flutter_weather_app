import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/weather_location.dart';

//detalle data class
class DetalleCardData {
  const DetalleCardData({
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

class WeatherSummaryData {
  const WeatherSummaryData({
    required this.title,
    required this.temperature,
    required this.feelsLike,
    required this.timeLabel,
    required this.rainLabel,
    required this.icon,
    required this.accentColor,
    required this.gradientStart,
    required this.gradientEnd,
  });

  final String title;
  final String temperature;
  final String feelsLike;
  final String timeLabel;
  final String rainLabel;
  final IconData icon;
  final Color accentColor;
  final Color gradientStart;
  final Color gradientEnd;
}

//forecast class
class HourlyForecastData {
  const HourlyForecastData({
    required this.time,
    required this.temperature,
    required this.weatherCode,
    required this.isDay,
  });

  final DateTime time;
  final double temperature;
  final int weatherCode;
  final bool isDay;
}

// a class that combines detalle data with forecast details
class WeatherData {
  const WeatherData({
    required this.summary,
    required this.currentCards,
    required this.hourlyForecast,
  });

  final WeatherSummaryData summary;
  final List<DetalleCardData> currentCards;
  final List<HourlyForecastData> hourlyForecast;
}

// fectch function that creates, populates, and return a WeatherData object
Future<WeatherData> fetchWeatherData(WeatherLocation location) async {
  final uri = Uri.parse(
    'https://api.open-meteo.com/v1/forecast?latitude=${location.latitude}&longitude=${location.longitude}&hourly=temperature_2m,weather_code,is_day&current=temperature_2m,apparent_temperature,is_day,rain,weather_code,cloud_cover,pressure_msl,wind_speed_10m,wind_direction_10m,wind_gusts_10m,precipitation,relative_humidity_2m,uv_index&timezone=auto&forecast_days=1',
  );

  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Request failed with status ${response.statusCode}');
  }

  final responseData = jsonDecode(response.body);

  // current day data with units
  final current = responseData['current'];
  final currentUnits = responseData['current_units'];
  final summary = _buildWeatherSummary(current);

  // Hourly forecast data for the current day
  final hourly = responseData['hourly'];
  final times =
      hourly['time']; // Array containing the date and time for each hour
  final temperatures =
      hourly['temperature_2m']; // Array containing the temperature for each hour
  final weatherCodes =
      hourly['weather_code']; // Array containing the weather code for each hour
  final dayValues =
      hourly['is_day']; // Array indicating whether each hour occurs during the day or at night

  // creating list of forecast data objects
  final hourlyForecast = List<HourlyForecastData>.generate(times.length, (
    index,
  ) {
    return HourlyForecastData(
      time: DateTime.parse(times[index]),
      temperature: temperatures[index],
      weatherCode: weatherCodes[index],
      isDay: dayValues[index] == 1,
    );
  });

  // creating list of current/detalle data objects
  final currentCards = <DetalleCardData>[
    DetalleCardData(
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
    DetalleCardData(
      title: 'UV index',
      metric: _formatNumber(current['uv_index']),
      caption: _getUvDescription((current['uv_index'] as num).toDouble()),
      icon: Icons.wb_sunny_outlined,
      iconBackground: const Color(0xFFE8D636),
      cardBackground: const Color(0xFF29466D),
      cardBorderColor: const Color(0xFF3A5A83),
      captionColor: _getUvColor((current['uv_index'] as num).toDouble()),
    ),
    DetalleCardData(
      title: 'Cloud cover',
      metric: '${current['cloud_cover']}${currentUnits['cloud_cover']}',
      caption: 'Sky coverage',
      icon: Icons.cloud_outlined,
      iconBackground: const Color(0xFF9EB2CC),
      cardBackground: const Color(0xFF29466D),
      cardBorderColor: const Color(0xFF3A5A83),
    ),
    DetalleCardData(
      title: 'Pressure',
      metric: _formatNumber(current['pressure_msl']),
      caption: currentUnits['pressure_msl'].toString(),
      icon: Icons.speed,
      iconBackground: const Color(0xFFB46DFF),
      cardBackground: const Color(0xFF29466D),
      cardBorderColor: const Color(0xFF3A5A83),
    ),
    DetalleCardData(
      title: 'Wind speed',
      metric: _formatNumber(current['wind_speed_10m']),
      caption: currentUnits['wind_speed_10m'].toString(),
      icon: Icons.air,
      iconBackground: const Color(0xFF20D7C5),
      cardBackground: const Color(0xFF29466D),
      cardBorderColor: const Color(0xFF3A5A83),
    ),
    DetalleCardData(
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
    DetalleCardData(
      title: 'Wind gusts',
      metric: _formatNumber(current['wind_gusts_10m']),
      caption: '${currentUnits['wind_gusts_10m']} peak',
      icon: Icons.air,
      iconBackground: const Color(0xFFF6A623),
      cardBackground: const Color(0xFF29466D),
      cardBorderColor: const Color(0xFF3A5A83),
    ),
    DetalleCardData(
      title: 'Precipitation',
      metric: _formatNumber(current['precipitation']),
      caption: '${currentUnits['precipitation']} / hr',
      icon: Icons.umbrella_outlined,
      iconBackground: const Color(0xFF75B9FF),
      cardBackground: const Color(0xFF29466D),
      cardBorderColor: const Color(0xFF3A5A83),
    ),
  ];

  return WeatherData(
    summary: summary,
    currentCards: currentCards,
    hourlyForecast: hourlyForecast,
  );
}

WeatherSummaryData _buildWeatherSummary(Map<String, dynamic> current) {
  final temperature = _formatNumber(current['temperature_2m']);
  final feelsLike = _formatNumber(current['apparent_temperature']);
  final precipitation = (current['precipitation'] as num?)?.toDouble() ?? 0;
  final rain = (current['rain'] as num?)?.toDouble() ?? 0;
  final cloudCover = (current['cloud_cover'] as num?)?.toDouble() ?? 0;
  final isDay = (current['is_day'] as num?)?.toInt() == 1;
  final weatherCode = (current['weather_code'] as num?)?.toInt() ?? 0;

  if (_isRainCode(weatherCode) || precipitation >= 1.0 || rain >= 1.0) {
    return WeatherSummaryData(
      title: precipitation < 1.0 && rain < 1.0 ? 'Light Rain' : 'Rainy',
      temperature: temperature,
      feelsLike: feelsLike,
      timeLabel: isDay ? 'Daytime' : 'Nighttime',
      rainLabel: _buildRainLabel(precipitation, rain),
      icon: Icons.water_drop_rounded,
      accentColor: const Color(0xFF8AB7FF),
      gradientStart: const Color(0xFF17335A),
      gradientEnd: const Color(0xFF3D5B9C),
    );
  }

  if (_isDrizzleCode(weatherCode) || precipitation > 0 || rain > 0) {
    return WeatherSummaryData(
      title: 'Drizzle',
      temperature: temperature,
      feelsLike: feelsLike,
      timeLabel: isDay ? 'Daytime' : 'Nighttime',
      rainLabel: _buildRainLabel(precipitation, rain),
      icon: Icons.grain_rounded,
      accentColor: const Color(0xFF86A9FF),
      gradientStart: const Color(0xFF1A315A),
      gradientEnd: const Color(0xFF36558F),
    );
  }

  if (_isCloudyCode(weatherCode) || cloudCover >= 80) {
    return WeatherSummaryData(
      title: 'Cloudy',
      temperature: temperature,
      feelsLike: feelsLike,
      timeLabel: isDay ? 'Daytime' : 'Nighttime',
      rainLabel: _buildRainLabel(precipitation, rain),
      icon: Icons.cloud_rounded,
      accentColor: const Color(0xFFD7E3FF),
      gradientStart: const Color(0xFF17213C),
      gradientEnd: const Color(0xFF34486E),
    );
  }

  if (_isPartlyCloudyCode(weatherCode) || cloudCover >= 30) {
    return WeatherSummaryData(
      title: 'Partly Cloudy',
      temperature: temperature,
      feelsLike: feelsLike,
      timeLabel: isDay ? 'Daytime' : 'Nighttime',
      rainLabel: _buildRainLabel(precipitation, rain),
      icon: isDay ? Icons.wb_cloudy_rounded : Icons.nightlight_round,
      accentColor: const Color(0xFFF0E4FF),
      gradientStart: const Color(0xFF162247),
      gradientEnd: const Color(0xFF314F7C),
    );
  }

  return WeatherSummaryData(
    title: isDay ? 'Clear Day' : 'Clear Night',
    temperature: temperature,
    feelsLike: feelsLike,
    timeLabel: isDay ? 'Daytime' : 'Nighttime',
    rainLabel: _buildRainLabel(precipitation, rain),
    icon: isDay ? Icons.wb_sunny_rounded : Icons.nightlight_round,
    accentColor: isDay ? const Color(0xFFFFD56A) : const Color(0xFFD9D4FF),
    gradientStart: const Color(0xFF132246),
    gradientEnd: const Color(0xFF2C3E67),
  );
}

String _buildRainLabel(double precipitation, double rain) {
  final amount = precipitation > 0 ? precipitation : rain;

  if (amount <= 0) {
    return 'No Rain';
  }

  return 'Raining ${amount.toStringAsFixed(amount < 1 ? 1 : 0)}mm';
}

bool _isRainCode(int code) => (code >= 71 && code <= 82) || code >= 95;

bool _isDrizzleCode(int code) => code >= 51 && code <= 57;

bool _isCloudyCode(int code) => code == 3;

bool _isPartlyCloudyCode(int code) => code == 1 || code == 2;

// helper functions for current/detalle data objects
String _formatNumber(dynamic value) {
  if (value is! num) {
    //to evade numeric conversion errors
    return value.toString();
  }

  if (value % 1 == 0) {
    //if it is an integer, convert directly to string without any transformation
    return value.toInt().toString();
  }

  return value.toStringAsFixed(
    1,
  ); // truncate the real number to one decimal place
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
