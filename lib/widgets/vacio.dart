import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Vacio extends StatelessWidget {
  const Vacio({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('🌍', style: TextStyle(fontSize: 55)),
          const SizedBox(height: 8),
          Text(
            'Find your weather',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 300,
            child: Text(
              'Search for any city or region to get real-time conditions and today\'s hourly forecast.',
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 148, 163, 184),
                height: 1.65,
              )
            ),
          ),
        ],
      ),
    );
  }
}
