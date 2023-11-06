import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/locations/locations.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class ScaffoldBodyList<T> extends StatelessWidget {
  final List<T> elements;
  final bool isLoading;
  final String loadingMessage;
  final String emptyMessage;

  const ScaffoldBodyList({
    super.key,
    required this.elements,
    required this.isLoading,
    required this.loadingMessage,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && elements.isEmpty) {
      return LoadingSpinner(
        message: loadingMessage,
      );
    }

    if (elements.isEmpty) {
      return CustomMessage(
        message: emptyMessage,
      );
    }

    switch (T) {
      case Character:
        return CharactersView(
          characters: elements as List<Character>,
        );
      case Location:
        return LocationsView(
          locations: elements as List<Location>,
        );
      default:
        return const SizedBox();
    }
  }
}
