import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty_app/features/characters/presentation/blocs/blocs.dart';
import 'package:rick_and_morty_app/features/characters/presentation/widgets/widgets.dart';
import 'package:rick_and_morty_app/features/shared/widgets/widgets.dart';

class CharactersView extends StatelessWidget {
  const CharactersView({
    super.key,
  });

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CharactersBloc, CharactersState>(
      bloc: BlocProvider.of<CharactersBloc>(context),
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          showSnackbar(context, state.errorMessage);
        }
      },
      child: BlocBuilder<CharactersBloc, CharactersState>(
        bloc: BlocProvider.of<CharactersBloc>(context),
        builder: (context, state) {
          if (state.isLoading && state.characters.isEmpty) {
            return const ScaffoldLoading();
          }

          return CharactersMansory(
            characters: state.characters,
            loadNextPage: context.read<CharactersBloc>().loadNextPage,
          );
        },
      ),
    );
  }
}
