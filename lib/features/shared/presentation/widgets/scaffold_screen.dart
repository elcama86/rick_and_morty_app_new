import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class ScaffoldScreen<T> extends StatelessWidget {
  final List<T> elements;
  final bool isLoading;

  const ScaffoldScreen({
    super.key,
    required this.elements,
    required this.isLoading,
  });

  AppBar? _appBarContain() {
    if (elements.isEmpty) {
      return AppBar(
        title: Text(Utils.appBarTitle(T)),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarContain(),
      body: _ScaffoldBody(
        elements: elements,
        isLoading: isLoading,
      ),
    );
  }
}

class _ScaffoldBody<T> extends StatelessWidget {
  final List<T> elements;
  final bool isLoading;

  const _ScaffoldBody({
    super.key,
    required this.elements,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading && elements.isEmpty) {
      return const LoadingSpinner();
    }

    if (elements.isEmpty) {
      return const CustomMessage(
        message: "No existen personajes cargados",
      );
    }

    switch (T) {
      case Character:
        return CharactersView(
          characters: elements as List<Character>,
          loadNextPage: context.read<CharactersBloc>().loadNextPage,
        );
      case Episode:
        return EpisodesView(
          episodes: elements as List<Episode>,
          loadNextPage: context.read<EpisodesBloc>().loadNextPage,
        );
      default:
        return const SizedBox();
    }
  }
}
