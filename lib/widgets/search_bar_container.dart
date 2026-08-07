import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './search_bar.dart';

class SearchBarContainer extends StatefulWidget {
  const SearchBarContainer({
    this.initialText = '',
    this.replaceCurrentRoute = false,
    super.key,
  });

  final String initialText;
  final bool replaceCurrentRoute;

  @override
  State<SearchBarContainer> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarContainer> {
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

      //to avoid stale search results in home when the mostrar-clima clear icon is pressed
      if (_controller.text.trim() != query.trim()) {
        return;
      }

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
    return SearchBarView(
      controller: _controller,
      searchCities: _searchCities,
      isLoading: _isLoading,
      searchResults: _searchResults,
      replaceCurrentRoute: widget.replaceCurrentRoute,
    );
  }
}
