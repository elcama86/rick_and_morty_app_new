import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';
import 'package:rick_and_morty_app/features/characters/presentation/widgets/widgets.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';


class ElementsMansory<T> extends StatelessWidget {
  final List<T> elements;

  const ElementsMansory({
    super.key,
    required this.elements,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0),
      sliver: SliverMasonryGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childCount: elements.length,
        itemBuilder: (context, index) {
          switch (T) {
            case Character:
              return CharacterPoster(
                character: elements[index] as Character,
              );
            case Episode:
              return EpisodePoster(
                episode: elements[index] as Episode,
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
