import 'package:flutter/material.dart';
import 'detalle_container.dart';
import 'header.dart';

class MostrarClima extends StatelessWidget {
  const MostrarClima({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Header(),
              SizedBox(height: 23),
              Expanded(child: DetalleContainer()),
            ],
          ),
        ),
      ),
    );
  }
}
