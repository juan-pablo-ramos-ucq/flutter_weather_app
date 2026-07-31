import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/weather_data.dart';

class HourlyForecastCard extends StatelessWidget {
  const HourlyForecastCard({required this.forecast, super.key});

  final HourlyForecastData forecast;

  @override
  Widget build(BuildContext context) {
    final iconStyle = _generateIconStyle(forecast.weatherCode, forecast.isDay);

    return Container(
      width: 58,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF29466D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3A5A83)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _formatHour(forecast.time),
            maxLines: 1,
            softWrap: false,
            style: GoogleFonts.nunito(
              color: const Color(0xFFB9C7DB),
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Icon(iconStyle.icon, color: iconStyle.color, size: 16),
          const SizedBox(height: 3),
          Text(
            '${forecast.temperature.round()}°',
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w800,
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

class _ForecastIcon {
  const _ForecastIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;
}

_ForecastIcon _generateIconStyle(int code, bool isDay) {
  if (code == 0) {
    return _ForecastIcon(
      icon: isDay ? Icons.wb_sunny_rounded : Icons.nightlight_round,
      color: isDay ? const Color(0xFFFFC83D) : const Color(0xFFFFE28A),
    );
  }

  if (code >= 1 && code <= 3) {
    return const _ForecastIcon(
      icon: Icons.cloud_rounded,
      color: Color(0xFFDDE6F2),
    );
  }

  if (code == 45 || code == 48) {
    return const _ForecastIcon(icon: Icons.blur_on, color: Color(0xFFC2CBD8));
  }

  if ((code >= 51 && code <= 67) || (code >= 80 && code <= 82)) {
    return const _ForecastIcon(
      icon: Icons.water_drop_rounded,
      color: Color(0xFF63AFFF),
    );
  }

  if ((code >= 71 && code <= 77) || code == 85 || code == 86) {
    return const _ForecastIcon(
      icon: Icons.ac_unit_rounded,
      color: Color(0xFFEAF6FF),
    );
  }

  if (code >= 95) {
    return const _ForecastIcon(
      icon: Icons.thunderstorm_rounded,
      color: Color(0xFFC7A4FF),
    );
  }

  return const _ForecastIcon(
    icon: Icons.cloud_outlined,
    color: Color(0xFFDDE6F2),
  );
}
