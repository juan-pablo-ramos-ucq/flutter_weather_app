import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(double lat, double lon, String name)? onCitySelected;

  const SearchBarWidget({super.key, this.onCitySelected});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: _controller,
            cursorColor: const Color(0xFF000000),
            onChanged: _searchCities,
            decoration: InputDecoration(
              icon: !_isLoading
                  ? const Icon(Icons.search, color: Colors.grey)
                  : Transform.scale(
                      scale: 0.5,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color.fromARGB(255, 148, 163, 184),
                      ),
                    ),
              hintText: "Search city or region...",
              hintStyle: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 148, 163, 184),
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
                      },
                    )
                  : null,
            ),
          ),
        ),
        if (_searchResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final city = _searchResults[index];
                final name = city['name'] ?? '';
                final country = city['country'] ?? '';
                final admin1 = city['admin1'] ?? '';
                final lat = city['latitude'];
                final lon = city['longitude'];

                return ListTile(
                  title: Text('$name, $country'),
                  subtitle: admin1.isNotEmpty ? Text(admin1) : null,
                  leading: const Icon(Icons.location_on_outlined),
                  onTap: () {
                    if (widget.onCitySelected != null) {
                      widget.onCitySelected!(lat, lon, name);
                    }
                    setState(() {
                      _controller.text = name;
                      _searchResults = [];
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
