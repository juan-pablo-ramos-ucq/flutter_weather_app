import 'package:flutter/material.dart';

class Vacio extends StatelessWidget {
  const Vacio({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
              '🌍',
              style: TextStyle(
                fontSize: 70,
              ),
          ),
          const SizedBox(height: 24),
          Text(
            'Find your weather',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: 280,
            child: Text(
              'Search for any city or region to get real-time conditions and today\'s hourly forecast.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}