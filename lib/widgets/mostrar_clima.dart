import 'package:flutter/material.dart';
import 'detalle_container.dart';

class MostrarClima extends StatelessWidget {
  const MostrarClima({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DetalleContainer()
            ],
          ),
        ),
      ),
    );
  }
}
