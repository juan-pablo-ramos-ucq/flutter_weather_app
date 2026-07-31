import 'package:flutter/material.dart';
import 'header.dart';
import 'vacio.dart';
import 'search_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
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
                    // bottom layer
                    const Vacio(),

                    // top layer
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
    );
  }
}