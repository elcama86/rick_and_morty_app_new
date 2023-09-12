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

          return ElementScaffoldScreen(
            appBarTitle: widget.characterName,
            element: character,
            id: widget.characterId,
            hasError: errorMessage.isNotEmpty,
          );
        },
      ),
    );
  }
}