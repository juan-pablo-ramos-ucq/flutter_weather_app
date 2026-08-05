import 'package:flutter/material.dart';
import '../models/weather_data.dart';
import 'package:google_fonts/google_fonts.dart';
import './summary_chip.dart';

class Summary extends StatelessWidget {
  const Summary({required this.summary, super.key});

  final SummaryData summary;

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
              SummaryChip(
                icon: Icons.schedule_rounded,
                label: summary.timeLabel,
              ),
              SummaryChip(
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