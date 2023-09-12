import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class CharacterScreen extends StatefulWidget {
  final String characterId;
  final String characterName;

  const CharacterScreen({
    super.key,
    required this.characterId,
    required this.characterName,
  });

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().getCharacter(widget.characterId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CharacterBloc, CharacterState>(
      bloc: BlocProvider.of<CharacterBloc>(context),
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty &&
            state.charactersMap[widget.characterId] == null) {
          SharedUtils.showSnackbar(context, state.errorMessage);
        }
      },
      child: BlocBuilder<CharacterBloc, CharacterState>(
        bloc: BlocProvider.of<CharacterBloc>(context),
        builder: (context, state) {
          final character = state.charactersMap[widget.characterId];
          final errorMessage = state.errorMessage;

          return _ScaffoldScreen(
            appBarTitle: widget.characterName,
            character: character,
            characterId: widget.characterId,
            hasError: errorMessage.isNotEmpty,
          );
        },
      ),
    );
  }
}

class _ScaffoldScreen extends StatelessWidget {
  final String appBarTitle;
  final Character? character;
  final String characterId;
  final bool hasError;

  const _ScaffoldScreen({
    required this.appBarTitle,
    this.character,
    required this.characterId,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: character == null
          ? AppBar(
              title: Text(appBarTitle),
            )
          : null,
      body: _ScaffoldBody(
        character: character,
        hasError: hasError,
      ),
      floatingActionButton: character == null && hasError
          ? FloatingActionButton(
              child: const Icon(Icons.refresh),
              onPressed: () =>
                  context.read<CharacterBloc>().getCharacter(characterId),
            )
          : null,
    );
  }
}

class _ScaffoldBody extends StatelessWidget {
  final Character? character;
  final bool hasError;

  const _ScaffoldBody({
    this.character,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    if (character == null && !hasError) {
      return const LoadingSpinner(
        message: 'loading_character',
      );
    }

    if (character == null && hasError) {
      return const CustomMessage(
        message: 'error_loading_character',
      );
    }

    return CharacterView(
      character: character!,
    );
  }
}
