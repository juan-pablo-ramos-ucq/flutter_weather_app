import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 37,
          height: 37,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF4FF),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(Icons.public, size: 23, color: Color(0xFF2997F5)),
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            Text(
              'WeatherScope',
              style: GoogleFonts.nunito(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.3,
              ),
            ),
            Text(
              'Real-time global weather',
              style: GoogleFonts.nunito(
                fontSize: 10.2,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 148, 163, 184),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
