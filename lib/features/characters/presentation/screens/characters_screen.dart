import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          if (state.isLoading && state.characters.isEmpty) {
            return const Scaffold(
              body: LoadingSpinner(),
            );
          }

          if (state.characters.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Personajes'),
              ),
              body: const CustomMessage(
                message: "No existen personajes cargados",
              ),
            );
          }

          return Scaffold(
            body: CharactersView(
              characters: state.characters,
              loadNextPage: context.read<CharactersBloc>().loadNextPage,
            ),
          );
        },
      ),
    );
  }
}
