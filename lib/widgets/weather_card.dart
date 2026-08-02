import 'package:flutter/material.dart';
import '../models/weather_data.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({required this.currentCard, super.key});

  final DetalleCardData currentCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: currentCard.cardBackground,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: currentCard.cardBorderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: currentCard.iconBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(currentCard.icon, size: 16, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              currentCard.title.toUpperCase(),
              style: GoogleFonts.nunito(
                color: const Color(0xFF9BA5BF),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              currentCard.metric,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              currentCard.caption,
              style: GoogleFonts.nunito(
                color: currentCard.captionColor ?? const Color(0xFF8994AF),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
