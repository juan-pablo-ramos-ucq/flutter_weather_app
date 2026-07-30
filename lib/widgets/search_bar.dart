import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import '../models/weather_location.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    this.initialText = '',
    this.replaceCurrentRoute = false,
    super.key,
  });

  final String initialText;
  final bool replaceCurrentRoute;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final TextEditingController _controller;
  List<dynamic> _searchResults = [];
  bool _isLoading = false;

  Future<void> _searchCities(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    final url = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search?name=${Uri.encodeComponent(query)}&count=6&language=en&format=json',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _searchResults = data['results'] ?? [];
        });
      }
    } catch (e) {
      debugPrint("Error buscando ciudad: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
            controller: _controller,
            cursorColor: Colors.black,
            onChanged: _searchCities,
            decoration: InputDecoration(
              icon: !_isLoading
                  ? const Icon(Icons.search, color: Colors.grey)
                  : Transform.scale(
                      scale: 0.5,
                      child: CircularProgressIndicator(
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
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () {
                        _controller.clear();
                        _searchCities('');

                        if (widget.replaceCurrentRoute) {
                          Navigator.pop(context);
                          FocusScope.of(context).unfocus();
                        }
                      },
                    )
                  : null,
            ),
          ),
        ),

        if (_searchResults.isNotEmpty)
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
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final city = _searchResults[index];
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

                      setState(() {
                        _controller.clear();
                        _searchResults = [];
                      });

                      if (widget.replaceCurrentRoute) {
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
