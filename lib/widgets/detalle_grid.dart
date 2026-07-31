import 'package:flutter/material.dart';
import '../models/weather_data.dart';
import 'detalle_card.dart';

class DetalleGrid extends StatelessWidget {
  const DetalleGrid({required this.data, super.key});

  final List<DetalleCardData> data;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: 144,
      ),
      itemBuilder: (BuildContext context, int index) {
        final DetalleCardData currentCard = data[index];

        return DetalleCard(currentCard: currentCard);
      },
    );
  }
}
