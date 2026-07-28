import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Decorative background that combines a dark vertical gradient, soft glows,
/// and deterministic stars. It is wrapped in [IgnorePointer] so it never
/// blocks taps or scrolling from the interface above it.
class NightSkyBackground extends StatelessWidget {
  const NightSkyBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF071029),
                  Color(0xFF091331),
                  Color(0xFF0D1737),
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
          ),
          const _Glow(
            alignment: Alignment(0.95, -0.75),
            color: Color(0xFF334A91),
            radius: 230,
          ),
          const _Glow(
            alignment: Alignment(-1.05, 0.85),
            color: Color(0xFF17396C),
            radius: 280,
          ),
          CustomPaint(
            painter: _StarFieldPainter(seed: 27, starCount: 78),
          ),
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({
    required this.alignment,
    required this.color,
    required this.radius,
  });

  final Alignment alignment;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: 0.22),
              color.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}

class _StarFieldPainter extends CustomPainter {
  _StarFieldPainter({required this.seed, required this.starCount});

  final int seed;
  final int starCount;

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(seed);

    for (var i = 0; i < starCount; i++) {
      final position = Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      );
      final radius = 0.45 + random.nextDouble() * 1.15;
      final opacity = 0.22 + random.nextDouble() * 0.55;

      final paint = Paint()
        ..color = const Color(0xFFDDE7FF).withValues(alpha: opacity);

      canvas.drawCircle(position, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarFieldPainter oldDelegate) {
    return oldDelegate.seed != seed || oldDelegate.starCount != starCount;
  }
}
