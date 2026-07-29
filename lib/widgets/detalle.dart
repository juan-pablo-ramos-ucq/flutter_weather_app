import 'package:flutter/material.dart';
import '../models/weather_card_data.dart';
import 'weather_card.dart';

class Detalle extends StatelessWidget {
  const Detalle({required this.data, super.key});

  final List<WeatherCardData> data;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (BuildContext context, int index){
        final WeatherCardData currentCard = data[index];

        return WeatherCard(currentCard: currentCard);
      },
    );
  }
}
