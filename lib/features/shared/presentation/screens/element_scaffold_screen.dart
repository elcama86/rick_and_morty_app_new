import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/locations/locations.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class ElementScaffoldScreen<T> extends StatelessWidget {
  final String appBarTitle;
  final T? element;
  final String id;
  final bool hasError;

  const ElementScaffoldScreen({
    super.key,
    required this.appBarTitle,
    this.element,
    required this.id,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: element == null
          ? AppBar(
              title: Text(appBarTitle),
            )
          : null,
      body: _ScaffoldBody(
        element: element,
        hasError: hasError,
      ),
      floatingActionButton: element == null && hasError
          ? FloatingActionButton(
              child: const Icon(Icons.refresh),
              onPressed: () => SharedUtils.getElement<T>(context, id),
            )
          : null,
    );
  }
}

class _ScaffoldBody<T> extends StatelessWidget {
  final T? element;
  final bool hasError;

  const _ScaffoldBody({
    this.element,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    if (element == null && !hasError) {
      return LoadingSpinner(
        message: SharedUtils.loadingElementMessage<T>(),
      );
    }

    if (element == null && hasError) {
      return CustomMessage(
        message: SharedUtils.errorLoadingElementMessage<T>(),
      );
    }

    switch (T) {
      case Character:
        return CharacterView(
          character: element! as Character,
        );
      case Episode:
        return EpisodeView(
          episode: element! as Episode,
        );
      case Location:
        return LocationView(
          location: element! as Location,
        );
      default:
        return const SizedBox();
    }
  }
}
