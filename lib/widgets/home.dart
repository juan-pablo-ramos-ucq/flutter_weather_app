import 'package:flutter/material.dart';

import 'header.dart';
import 'night_sky_background.dart';
import 'search_bar.dart';
import 'vacio.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const NightSkyBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 25,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Header(),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Stack(
                      children: [
                        // Bottom layer: empty/weather content.
                        const Vacio(),

                        // Top layer: location search interaction.
                        const Positioned.fill(
                          child: SearchBarWidget(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
