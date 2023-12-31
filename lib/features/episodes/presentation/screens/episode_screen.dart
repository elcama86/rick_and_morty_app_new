import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/config/config.dart';

import 'package:rick_and_morty_app/features/episodes/episodes.dart';
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
          SharedUtils.showSnackbar(context, state.errorMessage);
        }
      },
      child: BlocBuilder<EpisodeBloc, EpisodeState>(
        bloc: BlocProvider.of<EpisodeBloc>(context),
        builder: (context, state) {
          final episode = state.episodesMap[widget.episodeId];
          final errorMessage = state.errorMessage;

          return ElementScaffoldScreen(
            appBarTitle:
                '${AppLocalizations.of(context).translate('episode')} ${widget.episodeId}',
            element: episode,
            id: widget.episodeId,
            hasError: errorMessage.isNotEmpty,
          );
        },
      ),
    );
  }
}
