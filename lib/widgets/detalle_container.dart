import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/weather_data.dart';
import '../models/weather_location.dart';
import 'detalle.dart';

class DetalleContainer extends StatefulWidget {
  const DetalleContainer({required this.location, super.key});

  final WeatherLocation location;

  @override
  State<DetalleContainer> createState() => _DetalleContainerState();
}

class _DetalleContainerState extends State<DetalleContainer> {
  WeatherData? data;

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    try {
      final weatherData = await fetchWeatherData(widget.location);

      if (!mounted) return;

      setState(() {
        data = weatherData;
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

    final currentData = data;

    if (currentData == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        _WeatherSummaryPanel(summary: currentData.summary),
        const SizedBox(height: 18),
        Expanded(child: Detalle(data: currentData.currentCards)),
      ],
    );
  }
}

class _WeatherSummaryPanel extends StatelessWidget {
  const _WeatherSummaryPanel({required this.summary});

  final WeatherSummaryData summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [summary.gradientStart, summary.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(summary.icon, size: 58, color: summary.accentColor),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                summary.temperature,
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 78,
                  fontWeight: FontWeight.w900,
                  height: 0.9,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Text(
                  '°C',
                  style: GoogleFonts.nunito(
                    color: Colors.white.withValues(alpha: 0.62),
                    fontSize: 34,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            summary.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Feels ${summary.feelsLike}°C',
            style: GoogleFonts.nunito(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              _SummaryChip(
                icon: Icons.schedule_rounded,
                label: summary.timeLabel,
              ),
              _SummaryChip(
                icon: Icons.water_drop_outlined,
                label: summary.rainLabel,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
