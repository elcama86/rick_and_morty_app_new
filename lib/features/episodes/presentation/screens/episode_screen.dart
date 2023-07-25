import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/episodes/presentation/presentation.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class EpisodeScreen extends StatefulWidget {
  final String episodeId;

  const EpisodeScreen({
    super.key,
    required this.episodeId,
  });

  @override
  State<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends State<EpisodeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EpisodeBloc>().getEpisode(widget.episodeId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EpisodeBloc, EpisodeState>(
      bloc: BlocProvider.of<EpisodeBloc>(context),
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty &&
            state.episodesMap[widget.episodeId] == null) {
          Utils.showSnackbar(context, state.errorMessage);
        }
      },
      child: BlocBuilder<EpisodeBloc, EpisodeState>(
        bloc: BlocProvider.of<EpisodeBloc>(context),
        builder: (context, state) {
          final episode = state.episodesMap[widget.episodeId];
          final errorMessage = state.errorMessage;

          if (episode == null && errorMessage.isEmpty) {
            return const Scaffold(
              body: LoadingSpinner(),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Episodio ${widget.episodeId}'),
            ),
            body: episode == null && errorMessage.isNotEmpty
                ? const CustomMessage(
                    message: "No se pudo cargar el episodio seleccionado")
                : EpisodeView(
                    episode: episode!,
                  ),
          );
        },
      ),
    );
  }
}
