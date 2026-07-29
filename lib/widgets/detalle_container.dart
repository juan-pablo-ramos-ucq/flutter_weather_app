import 'package:flutter/material.dart';
import 'detalle.dart';

class DetalleContainer extends StatefulWidget {
  const DetalleContainer({super.key});

  @override
  State<DetalleContainer> createState() => _DetalleContainerState();
}

class _DetalleContainerState extends State<DetalleContainer> {
  late final List<WeatherCardData> data;

  @override
  void initState() {
    super.initState();

    
  }

  @override
  Widget build(BuildContext context) {
    return Detalle(data: data);
  }
}
