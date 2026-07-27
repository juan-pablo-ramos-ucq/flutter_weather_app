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
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              const Vacio(),
              const SizedBox(height: 20),
              SearchBarWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
