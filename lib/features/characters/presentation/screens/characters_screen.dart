import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';

import 'package:rick_and_morty_app/features/characters/presentation/blocs/blocs.dart';
import 'package:rick_and_morty_app/features/characters/presentation/views/views.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  void initState() {
    super.initState();
    final charactersState = context.read<CharactersBloc>().state;
    if (charactersState.characters.isEmpty &&
        charactersState.errorMessage.isEmpty) {
      context.read<CharactersBloc>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CharactersBloc, CharactersState>(
      bloc: BlocProvider.of<CharactersBloc>(context),
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty && !state.isLoading) {
          SharedUtils.showSnackbar(context, state.errorMessage);
        }
      },
      child: BlocBuilder<CharactersBloc, CharactersState>(
        bloc: BlocProvider.of<CharactersBloc>(context),
        builder: (context, state) {
          return _ScaffoldScreen(
            characters: state.characters,
            isLoading: state.isLoading,
            hasError: state.errorMessage.isNotEmpty,
          );
        },
      ),
    );
  }
}

class _ScaffoldScreen extends StatelessWidget {
  final List<Character> characters;
  final bool isLoading;
  final bool hasError;

  const _ScaffoldScreen({
    required this.characters,
    required this.isLoading,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedUtils.appBarContain(characters, "characters", context),
      body: _ScaffoldBody(
        characters: characters,
        isLoading: isLoading,
      ),
      floatingActionButton: hasError && !isLoading && characters.isEmpty
          ? FloatingActionButton(
              onPressed: context.read<CharactersBloc>().loadNextPage,
              child: const Icon(
                Icons.refresh,
              ),
            )
          : null,
    );
  }
}

class _ScaffoldBody extends StatelessWidget {
  final List<Character> characters;
  final bool isLoading;

  const _ScaffoldBody({
    required this.characters,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && characters.isEmpty) {
      return const LoadingSpinner(
        message: 'loading_characters',
      );
    }

    if (characters.isEmpty) {
      return const CustomMessage(
        message: "no_characters_loaded",
      );
    }

    return CharactersView(
      characters: characters,
      loadNextPage: context.read<CharactersBloc>().loadNextPage,
    );
  }
}
