import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/weather_data.dart';
import 'hourly_forecast_card.dart';

class HourlyForecastCarousel extends StatelessWidget {
  const HourlyForecastCarousel({required this.forecasts, super.key});

  final List<HourlyForecastData> forecasts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "TODAY'S HOURLY FORECAST",
          style: GoogleFonts.nunito(
            color: const Color(0xFF64748B),
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: forecasts.length,
            separatorBuilder: (_, _) {
              return const SizedBox(width: 8);
            },
            itemBuilder: (context, index) {
              return HourlyForecastCard(forecast: forecasts[index]);
            },
          ),
        ),
      ],
    );
  }
}
