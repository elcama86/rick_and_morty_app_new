import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';
import 'package:rick_and_morty_app/features/characters/presentation/blocs/blocs.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

typedef SearchCharactersCallback = Future<List<Character>> Function(
    String query);

class SearchCharactersDelegate extends SearchDelegate<Character?> {
  final SearchCharactersCallback searchCharacters;
  List<Character> initialCharacters;

  SearchCharactersDelegate({
    required this.searchCharacters,
    required this.initialCharacters,
  });

  StreamController<List<Character>> debounceCharacters =
      StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debouncerTimer;

  void _onQueryChanged(String query) {
    if (query.isNotEmpty) isLoadingStream.add(true);
    if (_debouncerTimer?.isActive ?? false) _debouncerTimer!.cancel();

    _debouncerTimer = Timer(const Duration(milliseconds: 500), () async {
      final characters = await searchCharacters(query);

      initialCharacters = characters;

      if (debounceCharacters.isClosed && isLoadingStream.isClosed) return;
      debounceCharacters.add(characters);
      isLoadingStream.add(false);
    });
  }

  void clearStreams() {
    debounceCharacters.close();
    isLoadingStream.close();
  }

  @override
  String get searchFieldLabel => "Buscar personaje";

  @override
  TextStyle? get searchFieldStyle => const TextStyle(fontSize: 24.0);

  Widget _buildSuggestionsAndResults(BuildContext context) {
    return StreamBuilder(
      initialData: initialCharacters,
      stream: debounceCharacters.stream,
      builder: (context, snapshot) {
        final errorMessage =
            context.watch<SearchCharactersBloc>().state.errorMessage;

        final characters = snapshot.data ?? [];

        if (characters.isEmpty && errorMessage.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomMessage(
              message: errorMessage,
            ),
          );
        }

        return ListView.builder(
          itemCount: characters.length,
          itemBuilder: (context, index) {
            return _CharacterItem(
              character: characters[index],
            );
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                onPressed: () => query = '',
                icon: const Icon(
                  Icons.refresh_rounded,
                ),
              ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
              onPressed: () {
                query = '';
                _onQueryChanged(query);
              },
              icon: const Icon(
                Icons.clear,
              ),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSuggestionsAndResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return _buildSuggestionsAndResults(context);
  }
}

class _CharacterItem extends StatelessWidget {
  final Character character;

  const _CharacterItem({
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textThemes = Theme.of(context).textTheme;

    return FadeIn(
      child: GestureDetector(
        onTap: () => context.push('/characters/character/${character.id}'),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage(
                    height: 150.0,
                    placeholder: const AssetImage('assets/images/cargando.gif'),
                    image: NetworkImage(character.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: textThemes.titleMedium,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    _InfoWithIcon(
                      info: character.status,
                      icon: Icons.monitor_heart_outlined,
                    ),
                    _InfoWithIcon(
                      info: character.species,
                      icon: Icons.hourglass_empty,
                    ),
                    _InfoWithIcon(
                      info: character.gender,
                      icon: Icons.wc,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoWithIcon extends StatelessWidget {
  const _InfoWithIcon({
    this.info = "No especificado",
    required this.icon,
  });

  final String info;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.titleSmall;

    return Row(
      children: [
        Icon(
          icon,
          size: 18.0,
        ),
        const SizedBox(
          width: 5.0,
        ),
        Text(
          info,
          style: textTheme,
        ),
      ],
    );
  }
}
