import 'package:flutter/material.dart';

import '../services/shared_preferences.dart';

class Avatar extends StatelessWidget {
  Avatar({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  final PreferencesService _prefsService = PreferencesService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.7,
          ),
        ),
        child: ClipOval(
          child: FutureBuilder<String>(
            future: _prefsService.getImgUrl(),
            builder: (context, snapshot) {
              final imageUrl = snapshot.data ?? '';

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                );
              }

              if (imageUrl.isEmpty) {
                return const Icon(
                  Icons.person,
                  color: Color(0xFF94A3B8),
                );
              }

              return Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) {
                  return const Icon(
                    Icons.person,
                    color: Color(0xFF94A3B8),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}