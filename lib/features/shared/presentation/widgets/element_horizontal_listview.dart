import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class ElementHorizontalListview<T, K> extends StatefulWidget {
  final List<T> elements;
  final K entity;
  final void Function(K entity, BuildContext context) loadNextElements;

  const ElementHorizontalListview({
    super.key,
    required this.elements,
    required this.entity,
    required this.loadNextElements,
  });

  @override
  State<ElementHorizontalListview<T, K>> createState() =>
      _ElementHorizontalListviewState<T, K>();
}

class _ElementHorizontalListviewState<T, K>
    extends State<ElementHorizontalListview<T, K>> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        return;
      }

      if ((controller.position.pixels + 200) >=
          controller.position.maxScrollExtent) {
        widget.loadNextElements(widget.entity, context);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: controller,
        itemCount: widget.elements.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          switch (T) {
            case Episode:
              return _Element(
                element: widget.elements[index] as Episode,
              );
            case Character:
              return _Element(
                element: widget.elements[index] as Character,
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class _Element<T> extends StatelessWidget {
  final T element;

  const _Element({
    required this.element,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleSmall;

    return GestureDetector(
      onTap: () => context.go(SharedUtils.getElementRoute(element)),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 135.0,
        child: Column(
          children: [
            FadeInRight(
              child: SharedUtils.getChildWidget(element),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: Text(
                SharedUtils.getElementName(element),
                textAlign: TextAlign.center,
                style: textStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
