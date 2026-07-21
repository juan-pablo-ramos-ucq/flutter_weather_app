import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF4FF),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.language,
                size: 32,
                color: Color(0xFF2997F5),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              children: [
                Text(
                  "WeatherScope",
                  style: textTheme.titleLarge,
                ),
                Text(
                  "Real-time global weather",
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
