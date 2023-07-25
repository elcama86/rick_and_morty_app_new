import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({super.key});

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  @override
  void initState() {
    super.initState();
    final episodesState = context.read<EpisodesBloc>().state;
    if (episodesState.episodes.isEmpty) {
      context.read<EpisodesBloc>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EpisodesBloc, EpisodesState>(
      bloc: BlocProvider.of<EpisodesBloc>(context),
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty && !state.isLoading) {
          Utils.showSnackbar(context, state.errorMessage);
        }
      },
      child: BlocBuilder<EpisodesBloc, EpisodesState>(
        bloc: BlocProvider.of<EpisodesBloc>(context),
        builder: (context, state) {
          if (state.isLoading && state.episodes.isEmpty) {
            return const Scaffold(
              body: LoadingSpinner(),
            );
          }

          if (state.episodes.isEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Episodios'),
              ),
              body:
                  const CustomMessage(message: "No existen episodios cargados"),
            );
          }

          return Scaffold(
            body: EpisodesView(
              episodes: state.episodes,
              loadNextPage: context.read<EpisodesBloc>().loadNextPage,
            ),
          );
        },
      ),
    );
  }
}
