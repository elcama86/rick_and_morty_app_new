import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';
import 'package:rick_and_morty_app/features/characters/presentation/presentation.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class SearchElementsDelegate<T> extends SearchDelegate<T?> {
  final Future<List<T>> Function(String query) searchElements;
  List<T> initialElements;

  SearchElementsDelegate({
    required this.searchElements,
    required this.initialElements,
  });

  StreamController<List<T>> debounceElements = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debouncerTimer;

  void _onQueryChanged(String query) {
    print('on query changed');
    print('query $query ${query.isNotEmpty}');
    if (query.isNotEmpty) isLoadingStream.add(true);
    print('debouncer ${_debouncerTimer?.isActive}');
    if (_debouncerTimer?.isActive ?? false) _debouncerTimer!.cancel();

    _debouncerTimer = Timer(const Duration(milliseconds: 500), () async {
      final List<T> elements = await searchElements(query);

      initialElements = elements;

      if (debounceElements.isClosed && isLoadingStream.isClosed) return;
      debounceElements.add(elements);
      isLoadingStream.add(false);
    });
  }

  void clearStreams() {
    debounceElements.close();
    isLoadingStream.close();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    );
  }

  @override
  String get searchFieldLabel => SharedUtils.searchLabel(T);

  @override
  TextStyle? get searchFieldStyle => const TextStyle(fontSize: 24.0);

  Widget _buildSuggestionsAndResults(BuildContext context) {
    return StreamBuilder(
      initialData: initialElements,
      stream: debounceElements.stream,
      builder: (context, snapshot) {
        final errorMessage = SharedUtils.watchError(T, context);

        final elements = snapshot.data ?? [];

        if (elements.isEmpty && errorMessage.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomMessage(
              message: errorMessage,
            ),
          );
        }

        return ListView.builder(
          itemCount: elements.length,
          itemBuilder: (context, index) {
            switch (T) {
              case Character:
                return CharacterSearchedItem(
                  character: elements[index] as Character,
                );
              case Episode:
                return EpisodeSearchedItem(
                  episode: elements[index] as Episode,
                );
              default:
                return const SizedBox();
            }
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(
                  Icons.refresh_rounded,
                ),
              ),
            );
          }

          return FadeIn(
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
        },
      ),
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
    print('entre');
    _onQueryChanged(query);
    return _buildSuggestionsAndResults(context);
  }
}
