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
    if (context.read<CharactersBloc>().state.characters.isEmpty) {
      context.read<CharactersBloc>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CharactersBloc, CharactersState>(
      bloc: BlocProvider.of<CharactersBloc>(context),
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty && !state.isLoading) {
          Utils.showSnackbar(context, state.errorMessage);
        }
      },
      child: BlocBuilder<CharactersBloc, CharactersState>(
        bloc: BlocProvider.of<CharactersBloc>(context),
        builder: (context, state) {
          return _ScaffoldScreen(
            characters: state.characters,
            isLoading: state.isLoading,
          );
        },
      ),
    );
  }
}

class _ScaffoldScreen extends StatelessWidget {
  final List<Character> characters;
  final bool isLoading;
  const _ScaffoldScreen({
    required this.characters,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.appBarContain(characters, "Personajes"),
      body: _ScaffoldBody(
        characters: characters,
        isLoading: isLoading,
      ),
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
      return const LoadingSpinner();
    }

    if (characters.isEmpty) {
      return const CustomMessage(
        message: "No existen personajes cargados",
      );
    }

    return CharactersView(
      characters: characters,
      loadNextPage: context.read<CharactersBloc>().loadNextPage,
    );
  }
}
