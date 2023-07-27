import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/shared/presentation/delegates/search_elements_delegate.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';
import 'package:rick_and_morty_app/features/characters/presentation/blocs/blocs.dart';
import 'package:rick_and_morty_app/features/shared/presentation/widgets/widgets.dart';

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
    final appBarTitleTheme = Theme.of(context).appBarTheme.titleTextStyle;

    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              "Personajes",
              style: appBarTitleTheme,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                final searchCharactersState =
                    context.read<SearchCharactersBloc>().state;

                final searchCharacters = context
                    .read<SearchCharactersBloc>()
                    .searchCharactersByQuery;

                showSearch<Character?>(
                  query: searchCharactersState.query,
                  context: context,
                  delegate: SearchElementsDelegate(
                    searchElements: searchCharacters,
                    initialElements: searchCharactersState.results,
                  ),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        ElementsMansory(
          elements: widget.characters,
        ),
      ],
    );
  }
}
