import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/domain/domain.dart';
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
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              title,
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
  State<_ElementList> createState() => _ElementListState();
}

class _ElementListState extends State<_ElementList> {
  @override
  void initState() {
    super.initState();
    final elements = Utils.getElements(widget.entity, context);
    if (elements == null) {
      Utils.loadElements(widget.entity, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final elements = Utils.watchElements(widget.entity, context);

    final hasError = Utils.watchElementHasError(widget.entity, context);

    final textStyle = Theme.of(context).textTheme.titleSmall;

    if (elements == null) {
      if (hasError) {
        return SizedBox(
          height: 200.0,
          child: Center(
            child: Text(
              Utils.getLoadingElementMessageError(widget.entity),
              style: textStyle,
            ),
          ),
        );
      }
      return const SizedBox(
        height: 200.0,
        child: Center(
          child: LoadingSpinner(),
        ),
      );
    }

    switch (widget.entity.runtimeType) {
      case Character:
        return ElementHorizontalListview(
          elements: List<Episode>.from(elements),
          entity: widget.entity as Character,
          loadNextElements: Utils.loadElements,
        );
      case Episode:
        return ElementHorizontalListview(
          elements: List<Character>.from(elements),
          entity: widget.entity as Episode,
          loadNextElements: Utils.loadElements,
        );
      default:
        return const SizedBox();
    }
  }
}
