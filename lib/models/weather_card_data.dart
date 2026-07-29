import 'package:flutter/material.dart';

class WeatherCardData {
  const WeatherCardData({
    required this.title,
    required this.metric,
    required this.caption,
    required this.icon,
    required this.iconBackground,
    required this.cardBackground,
    required this.cardBorderColor,
    this.captionColor,
  });

  final String title;
  final String metric;
  final String caption;
  final IconData icon;
  final Color iconBackground;
  final Color cardBackground;
  final Color cardBorderColor;
  final Color? captionColor;
}