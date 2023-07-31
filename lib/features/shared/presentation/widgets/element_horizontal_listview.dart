import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

import 'package:rick_and_morty_app/features/episodes/domain/domain.dart';
import 'package:rick_and_morty_app/features/episodes/presentation/widgets/widgets.dart';

class ElementHorizontalListview<T> extends StatefulWidget {
  final List<T> elements;
  final String entityId;
  final List<String> elementsIds;
  final Future<void> Function(String, List<String>) loadNextPage;

  const ElementHorizontalListview({
    super.key,
    required this.elements,
    required this.entityId,
    required this.elementsIds,
    required this.loadNextPage,
  });

  @override
  State<ElementHorizontalListview> createState() =>
      _ElementHorizontalListviewState();
}

class _ElementHorizontalListviewState extends State<ElementHorizontalListview> {
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
        widget.loadNextPage(widget.entityId, widget.elementsIds);
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
          switch (widget.runtimeType) {
            case const (ElementHorizontalListview<Episode>):
              return _Episode(
                episode: widget.elements[index],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

class _Episode extends StatelessWidget {
  final Episode episode;

  const _Episode({
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleSmall;

    return GestureDetector(
      onTap: () => context.go('/episodes/episode/${episode.id}'),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 135.0,
        child: Column(
          children: [
            FadeInRight(
              child: EpisodeCard(
                episode: episode,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: Text(
                episode.name,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
