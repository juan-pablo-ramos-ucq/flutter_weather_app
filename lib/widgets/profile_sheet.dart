import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_info_tile.dart';

// context - the parent widget

class ProfileSheet extends StatelessWidget {
  const ProfileSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      height: screenHeight * 0.70,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 12, 30, 30),
        child: Column(
          children: [
            // Drag indicator
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(100),
              ),
            ),

            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFFF1F5F9),
                ),
                icon: const Icon(Icons.close, color: Color(0xFF94A3B8)),
              ),
            ),

            Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2E8F0), width: 3)
              ),
              child: ClipOval(
                child: Image.network(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d'
                  '?w=300&h=300&fit=crop',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Alex Rivera',
              style: GoogleFonts.nunito(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF172033),
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              'WeatherScope Member',
              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
            ),

            const SizedBox(height: 30),

            const ProfileInfoTile(
              icon: Icons.person_outline,
              label: 'FULL NAME',
              value: 'Alex Rivera',
              iconColor: Color(0xFF8B5CF6),
              iconBackground: Color(0xFFF1EAFE),
            ),

            const SizedBox(height: 14),

            const ProfileInfoTile(
              icon: Icons.mail_outline,
              label: 'EMAIL',
              value: 'alex.rivera@weatherscope.app',
              iconColor: Color(0xFF4F8DF7),
              iconBackground: Color(0xFFE5EFFF),
            ),
          ],
        ),
      ),
    );
  }
}
