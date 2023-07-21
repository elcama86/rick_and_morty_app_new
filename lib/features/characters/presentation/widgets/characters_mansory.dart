import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';

import 'character_poster.dart';

class CharactersMansory extends StatefulWidget {
  final List<Character> characters;
  final VoidCallback? loadNextPage;

  const CharactersMansory({
    super.key,
    required this.characters,
    this.loadNextPage,
  });

  @override
  State<CharactersMansory> createState() => _CharactersMansoryState();
}

class _CharactersMansoryState extends State<CharactersMansory> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((controller.position.pixels + 100) >=
          controller.position.maxScrollExtent) {
        widget.loadNextPage!();
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: MasonryGridView.count(
        controller: controller,
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        itemCount: widget.characters.length,
        itemBuilder: (context, index) {
          return CharacterPoster(
            character: widget.characters[index],
          );
        },
      ),
    );
  }
}
