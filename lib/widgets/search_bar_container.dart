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
  State<SearchBarContainer> createState() => _SearchBarContainerState();
}

class _SearchBarContainerState extends State<SearchBarContainer> {
  late final TextEditingController _controller;
  List<dynamic> _searchResults = [];
  bool _isLoading = false;
  Timer? _debounce;
  int _latestRequestId = 0; // This variable is state that does not trigger a re-render but persists between re-renders because it does not use setState().

  void _onSearchChanged(String query) {
    _debounce?.cancel();

    /*
    await http.get(...) suspends the killing of the _searchCities() execution, and in turn _onSearchChanged,
    and because the function is still alive, _onSearchChanged's local requestId remains alive too.

    Each call instance of the _onSearchChanged function has its own local variable values (i.e., requestId),
    even when all function instances share the same variable names.

    In essence, requestId is the historical snapshot of each individual _onSearchChanged() GET fetch, while
    ++_latestRequestId represents the current freshly GET fetch request.
    */
    final requestId = ++_latestRequestId;

    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
      return;
    }

    setState(() => _isLoading = true);

    _debounce = Timer(
      const Duration(milliseconds: 500), // Espera 500 ms antes de invocar _searchCities y hacer la consulta a la API; por lo tanto, lo más rápido que puede consultar la API el usuario (entre consultas) es cada medio segundo. Durante esos 500 ms, _debounce?.cancel() puede cancelar el Timer y evitar que se haga el fetch y, por lo tanto, que salgan varios SnackBars.
      () => _searchCities(query, requestId),
    );
  }

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

  Future<void> _searchCities(String query, int requestId) async {
    final url = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search'
      '?name=${Uri.encodeComponent(query)}'
      '&count=6&language=en&format=json',
    );

    bool isLatestRequest() {
      return mounted && requestId == _latestRequestId;
    }

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));

      if (!isLatestRequest()) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          _searchResults = data['results'] ?? [];
        });
      } else {
        setState(() => _searchResults = []);

        _showErrorSnackBar(
          'Search service error (${response.statusCode}). Please try again.',
        );
      }
    } on TimeoutException {
      if (!isLatestRequest()) return;

      setState(() => _searchResults = []);

      _showErrorSnackBar(
        'Connection timed out. Check your internet connection.',
      );
    } on http.ClientException {
      if (!isLatestRequest()) return;

      setState(() => _searchResults = []);

      _showErrorSnackBar('Could not connect. Check your internet connection.');
    } on FormatException {
      if (!isLatestRequest()) return;

      setState(() => _searchResults = []);

      _showErrorSnackBar('The search service returned an invalid response.');
    } catch (error) {
      if (!isLatestRequest()) return;

      debugPrint('Error searching for city: $error');

      setState(() => _searchResults = []);

      _showErrorSnackBar('Something went wrong. Please try again.');
    } finally {
      if (isLatestRequest()) {
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
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchBarView(
      controller: _controller,
      searchCities: _onSearchChanged,
      isLoading: _isLoading,
      searchResults: _searchResults,
      replaceCurrentRoute: widget.replaceCurrentRoute,
    );
  }
}
