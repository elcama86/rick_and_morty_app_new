import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';

import 'character_poster.dart';

class CharactersMansory extends StatelessWidget {
  final List<Character> characters;

  const CharactersMansory({
    super.key,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 10.0),
      sliver: SliverMasonryGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childCount: characters.length,
        itemBuilder: (context, index) {
          return CharacterPoster(
            character: characters[index],
          );
        },
      ),
    );
  }
}
