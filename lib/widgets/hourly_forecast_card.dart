import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/hourly_forecast_data.dart';

class HourlyForecastCard extends StatelessWidget {
  const HourlyForecastCard({required this.forecast, super.key});

  final HourlyForecastData forecast;

  @override
  Widget build(BuildContext context) {
    final appearance = _appearanceFor(forecast.weatherCode, forecast.isDay);

    return Container(
      width: 105,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF29466D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF3A5A83)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _formatHour(forecast.time),
            style: GoogleFonts.nunito(
              color: const Color(0xFFB9C7DB),
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          Icon(appearance.icon, color: appearance.color, size: 35),
          Text(
            appearance.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.nunito(
              color: const Color(0xFF9BAAC0),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '${forecast.temperature.round()}°',
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

String _formatHour(DateTime time) {
  final hour = time.hour;
  final period = hour < 12 ? 'am' : 'pm';
  final formattedHour = hour % 12 == 0 ? 12 : hour % 12;

  return '$formattedHour$period';
}

class _WeatherAppearance {
  const _WeatherAppearance({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;
}

_WeatherAppearance _appearanceFor(int code, bool isDay) {
  if (code == 0) {
    return _WeatherAppearance(
      icon: isDay ? Icons.wb_sunny_rounded : Icons.nightlight_round,
      label: isDay ? 'Soleado' : 'Noche clara',
      color: isDay ? const Color(0xFFFFC83D) : const Color(0xFFFFE28A),
    );
  }

  if (code >= 1 && code <= 3) {
    return const _WeatherAppearance(
      icon: Icons.cloud_rounded,
      label: 'Nublado',
      color: Color(0xFFDDE6F2),
    );
  }

  if (code == 45 || code == 48) {
    return const _WeatherAppearance(
      icon: Icons.blur_on,
      label: 'Niebla',
      color: Color(0xFFC2CBD8),
    );
  }

  if ((code >= 51 && code <= 67) || (code >= 80 && code <= 82)) {
    return const _WeatherAppearance(
      icon: Icons.water_drop_rounded,
      label: 'Lluvia',
      color: Color(0xFF63AFFF),
    );
  }

  if ((code >= 71 && code <= 77) || code == 85 || code == 86) {
    return const _WeatherAppearance(
      icon: Icons.ac_unit_rounded,
      label: 'Nieve',
      color: Color(0xFFEAF6FF),
    );
  }

  if (code >= 95) {
    return const _WeatherAppearance(
      icon: Icons.thunderstorm_rounded,
      label: 'Tormenta',
      color: Color(0xFFC7A4FF),
    );
  }

  return const _WeatherAppearance(
    icon: Icons.cloud_outlined,
    label: 'Variable',
    color: Color(0xFFDDE6F2),
  );
}
