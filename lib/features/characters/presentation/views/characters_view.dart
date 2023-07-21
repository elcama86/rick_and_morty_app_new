import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';
import 'package:rick_and_morty_app/features/characters/presentation/widgets/widgets.dart';

class CharactersView extends StatefulWidget {
  final List<Character> characters;
  final VoidCallback? loadNextPage;

  const CharactersView({
    super.key,
    required this.characters,
    this.loadNextPage,
  });

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
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
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text("Personajes"),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        CharactersMansory(
          characters: widget.characters,
        ),
      ],
    );
  }
}
