import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_info_tile.dart';

class ProfileSheet extends StatelessWidget {
  const ProfileSheet({super.key, required this.userData});

  final Future<List<String?>> userData;

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
                icon: const Icon(
                  Icons.close,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ),

            Expanded(
              child: FutureBuilder<List<String?>>(
                future: userData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('No se pudo cargar el perfil'),
                    );
                  }

                  final name = snapshot.data?[0] ?? '';
                  final imageUrl = snapshot.data?[1] ?? '';
                  final email = snapshot.data?[2] ?? '';

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: 108,
                          height: 108,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 3,
                            ),
                          ),
                          child: ClipOval(
                            child: imageUrl.isNotEmpty
                                ? Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) =>
                                        const Icon(Icons.person, size: 50),
                                  )
                                : const Icon(Icons.person, size: 50),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          name,
                          style: GoogleFonts.nunito(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF172033),
                          ),
                        ),

                        const SizedBox(height: 4),

                        const Text(
                          'WeatherScope Member',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 30),

                        ProfileInfoTile(
                          icon: Icons.person_outline,
                          label: 'FULL NAME',
                          value: name,
                          iconColor: const Color(0xFF8B5CF6),
                          iconBackground: const Color(0xFFF1EAFE),
                        ),

                        const SizedBox(height: 14),

                        ProfileInfoTile(
                          icon: Icons.mail_outline,
                          label: 'EMAIL',
                          value: email,
                          iconColor: const Color(0xFF4F8DF7),
                          iconBackground: const Color(0xFFE5EFFF),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}