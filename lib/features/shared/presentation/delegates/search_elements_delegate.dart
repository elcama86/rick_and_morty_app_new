import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class SearchElementsDelegate<T> extends SearchDelegate<T?> {
  final Future<List<T>> Function(String query) searchElements;
  List<T> initialElements;
  final String label;

  SearchElementsDelegate({
    required this.searchElements,
    required this.initialElements,
    required this.label,
  });

  StreamController<List<T>> debounceElements = StreamController.broadcast();

  Timer? _debouncerTimer;

  void _onQueryChanged(String query) {
    if (_debouncerTimer?.isActive ?? false) _debouncerTimer!.cancel();

    _debouncerTimer = Timer(const Duration(milliseconds: 500), () async {
      final List<T> elements = await searchElements(query);

      initialElements = elements;

      if (debounceElements.isClosed) return;
      debounceElements.add(elements);
    });
  }

  void clearStreams() {
    debounceElements.close();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;

    return Theme.of(context).copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
            bodyLarge: appBarTheme.titleTextStyle,
          ),
    );
  }

  @override
  String get searchFieldLabel => label;

  @override
  TextStyle? get searchFieldStyle => const TextStyle(fontSize: 25.0);

  Widget _buildSuggestionsAndResults(BuildContext context) {
    return StreamBuilder(
      initialData: initialElements,
      stream: debounceElements.stream,
      builder: (context, snapshot) {
        final elements = snapshot.data ?? [];

        return SharedUtils.suggestionsAndResultsWidget<T>(context, elements);
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    final loadingSpinner = SpinPerfect(
      duration: const Duration(seconds: 20),
      spins: 10,
      infinite: true,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Icon(
          Icons.refresh_rounded,
        ),
      ),
    );

    final closeSearch = FadeIn(
      animate: query.isNotEmpty,
      child: IconButton(
        onPressed: () {
          query = '';
          _onQueryChanged(query);
        },
        icon: const Icon(
          Icons.clear,
        ),
      ),
    );

    return [
      SharedUtils.actionSearchWidget<T>(context, loadingSpinner, closeSearch),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSuggestionsAndResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return _buildSuggestionsAndResults(context);
  }
}
