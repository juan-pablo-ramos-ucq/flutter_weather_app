import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/weather_location.dart';

class SearchBarView extends StatelessWidget {
  const SearchBarView({
    required this.controller,
    required this.searchCities,
    required this.isLoading,
    required this.searchResults,
    this.replaceCurrentRoute = false,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> searchCities;
  final bool isLoading;
  final List<dynamic> searchResults;
  final bool replaceCurrentRoute;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            cursorColor: Colors.black,
            onChanged: searchCities,
            decoration: InputDecoration(
              icon: !isLoading
                  ? const Icon(Icons.search, color: Colors.grey)
                  : Transform.scale(
                      scale: 0.5,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
              hintText: 'Search city or region...',
              hintStyle: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF94A3B8),
                fontSize: 12,
                height: 1.65,
              ),
              border: InputBorder.none,
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () {
                        controller.clear();
                        searchCities('');

                        if (replaceCurrentRoute) {
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context);
                        }
                      },
                    )
                  : null,
            ),
          ),
        ),
        if (searchResults.isNotEmpty)
          Positioned(
            top: 64,
            left: 0,
            right: 0,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 420),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final city = searchResults[index];
                  final name = city['name'] ?? '';
                  final country = city['country'] ?? '';
                  final admin1 = city['admin1'] ?? '';

                  return ListTile(
                    title: Text('$name, $country'),
                    subtitle: admin1.isNotEmpty ? Text(admin1) : null,
                    leading: const Icon(Icons.location_on_outlined),
                    onTap: () {
                      final location = WeatherLocation(
                        label: [
                          name,
                          if (admin1.isNotEmpty) admin1,
                          country,
                        ].join(', '),
                        latitude: (city['latitude'] as num).toDouble(),
                        longitude: (city['longitude'] as num).toDouble(),
                      );

                      controller.clear();
                      searchCities('');

                      if (replaceCurrentRoute) {
                        Navigator.pushReplacementNamed(
                          context,
                          '/weather',
                          arguments: location,
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          '/weather',
                          arguments: location,
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}