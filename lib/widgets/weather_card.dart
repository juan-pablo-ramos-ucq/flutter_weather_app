import 'package:flutter/material.dart';
import '../models/weather_card_data.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    required this.currentCard,
    super.key,
  });

  final WeatherCardData currentCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: currentCard.cardBackground,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: currentCard.cardBorderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: currentCard.iconBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(currentCard.icon, size: 25, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              currentCard.title.toUpperCase(),
              style: GoogleFonts.nunito(
                color: const Color(0xFF9BA5BF),
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              currentCard.metric,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              currentCard.caption,
              style: GoogleFonts.nunito(
                color: currentCard.captionColor ?? const Color(0xFF8994AF),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
