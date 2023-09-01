import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:rick_and_morty_app/config/config.dart';
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
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElementsScrollView(
      controller: controller,
      elements: widget.characters,
      title: "characters",
      actions: [
        FadeIn(
          child: IconButton(
            onPressed: () {
              final searchCharactersState =
                  context.read<SearchCharactersBloc>().state;

              final searchCharacters =
                  context.read<SearchCharactersBloc>().searchCharactersByQuery;

              showSearch<Character?>(
                query: searchCharactersState.query,
                context: context,
                delegate: SearchElementsDelegate(
                  searchElements: searchCharacters,
                  initialElements: searchCharactersState.results,
                  label: AppLocalizations.of(context).translate('search_character'),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ),
      ],
      loadNextPage: widget.loadNextPage,
    );
  }
}
