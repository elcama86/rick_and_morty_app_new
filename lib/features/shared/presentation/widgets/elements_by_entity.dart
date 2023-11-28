import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/config/localizations/app_localizations.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/locations/locations.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class ElementsByEntity<T> extends StatelessWidget {
  final String title;
  final T entity;

  const ElementsByEntity({
    super.key,
    required this.title,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return SizedBox(
      height: 300.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              AppLocalizations.of(context).translate(title),
              style: textStyle,
            ),
          ),
          _ElementList(
            entity: entity,
          ),
        ],
      ),
    );
  }
}

class _ElementList<T> extends StatefulWidget {
  final T entity;

  const _ElementList({
    required this.entity,
  });

  @override
  State<_ElementList> createState() => _ElementListState<T>();
}

class _ElementListState<T> extends State<_ElementList> {
  @override
  void initState() {
    super.initState();
    if (SharedUtils.getElements<T>(
            widget.entity.id.toString(), true, context) ==
        null) {
      SharedUtils.loadElements<T>(widget.entity, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final elements =
        SharedUtils.getElements<T>(widget.entity.id.toString(), false, context);

    final hasError = SharedUtils.watchElementHasError<T>(context);

    if (elements == null) {
      if (hasError) {
        return _NoElementsMessage(
          message: AppLocalizations.of(context).translate(
            SharedUtils.loadingElementsMessageError<T>(),
          ),
        );
      }

      return const SizedBox(
        height: 200.0,
        child: LoadingSpinner(),
      );
    }

    if (elements.isEmpty) {
      return _NoElementsMessage(
        message: AppLocalizations.of(context).translate(
          SharedUtils.elementsEmptyMessage<T>(),
        ),
      );
    }

    switch (T) {
      case Character:
        return ElementHorizontalListview<Episode, T>(
          elements: List<Episode>.from(elements),
          entity: widget.entity,
          loadNextElements: SharedUtils.loadElements,
        );
      case Episode || Location:
        return ElementHorizontalListview<Character, T>(
          elements: List<Character>.from(elements),
          entity: widget.entity,
          loadNextElements: SharedUtils.loadElements,
        );
      default:
        return const SizedBox();
    }
  }
}

class _NoElementsMessage extends StatelessWidget {
  final String message;

  const _NoElementsMessage({
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleSmall;

    return SizedBox(
      height: 200.0,
      child: Center(
        child: Text(
          message,
          style: textStyle,
        ),
      ),
    );
  }
}
