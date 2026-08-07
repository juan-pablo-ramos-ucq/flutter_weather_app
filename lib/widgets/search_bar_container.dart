import 'dart:async';
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

  void _showErrorSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
  }

  Future<void> _searchCities(String query) async {
    /*
    await http.get(...) suspends the killing of _searchCities() execution, and because the function is still alive,
    its local trimmedQuery remains alive too.

    Each call instance of the _searchCities async function has its own local variable values (i.e., trimmedQuery),
    even when all function instances share the same variable names.

    In essence, trimmedQuery is the historical snapshot of each individual _searchCities() GET fetch, while 
    _controller.text.trim() is the current freshly typed user query.
    */
    final trimmedQuery = query.trim(); // 
    if (trimmedQuery.isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    final url = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search'
      '?name=${Uri.encodeComponent(trimmedQuery)}'
      '&count=6&language=en&format=json',
    );

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));

      if (!mounted || _controller.text.trim() != trimmedQuery) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          _searchResults = data['results'] ?? [];
        });
      } else {
        setState(() {
          _searchResults = [];
        });

        _showErrorSnackBar(
          'Search service error (${response.statusCode}). Please try again.',
        );
      }
    } on TimeoutException {
      if (!mounted || _controller.text.trim() != trimmedQuery) return;

      setState(() {
        _searchResults = [];
      });

      _showErrorSnackBar(
        'Connection timed out. Check your internet connection.',
      );
    } on http.ClientException {
      if (!mounted || _controller.text.trim() != trimmedQuery) return;

      setState(() {
        _searchResults = [];
      });

      _showErrorSnackBar('Could not connect. Check your internet connection.');
    } on FormatException {
      if (!mounted || _controller.text.trim() != trimmedQuery) return;

      setState(() {
        _searchResults = [];
      });

      _showErrorSnackBar('The search service returned an invalid response.');
    } catch (error) {
      if (!mounted || _controller.text.trim() != trimmedQuery) return;

      debugPrint('Error searching for city: $error');

      setState(() {
        _searchResults = [];
      });

      _showErrorSnackBar('Something went wrong. Please try again.');
    } finally {
      if (mounted && _controller.text.trim() == trimmedQuery) {
        setState(() => _isLoading = false);
      }
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
