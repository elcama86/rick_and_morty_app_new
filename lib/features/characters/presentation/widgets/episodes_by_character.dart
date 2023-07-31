import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/domain/domain.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class EpisodesByCharacter extends StatelessWidget {
  final String title;
  final Character character;

  const EpisodesByCharacter({
    super.key,
    required this.title,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return SizedBox(
      height: 300.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              title,
              style: textStyle,
            ),
          ),
          _EpisodesList(
            character: character,
          ),
        ],
      ),
    );
  }
}

class _EpisodesList extends StatefulWidget {
  final Character character;

  const _EpisodesList({
    required this.character,
  });

  @override
  State<_EpisodesList> createState() => _EpisodesListState();
}

class _EpisodesListState extends State<_EpisodesList> {
  @override
  void initState() {
    super.initState();
    final episodes = context
        .read<EpisodesByCharacterBloc>()
        .state
        .episodesByCharacter[widget.character.id.toString()]?['episodes'];
    if (episodes == null) {
      final ids = Utils.getIdsFromUrl(widget.character.episodes);
      context
          .read<EpisodesByCharacterBloc>()
          .loadEpisodes(widget.character.id.toString(), ids);
    }
  }

  @override
  Widget build(BuildContext context) {
    final episodes = context
        .watch<EpisodesByCharacterBloc>()
        .state
        .episodesByCharacter[widget.character.id.toString()]?['episodes'];

    final hasError = context.watch<EpisodesByCharacterBloc>().state.hasError;

    final textStyle = Theme.of(context).textTheme.titleSmall;

    if (episodes == null) {
      if (hasError) {
        return SizedBox(
          height: 200.0,
          child: Center(
            child: Text(
              'Los episodios no pudieron ser cargados',
              style: textStyle,
            ),
          ),
        );
      }
      return const SizedBox(
        height: 200.0,
        child: Center(
          child: LoadingSpinner(),
        ),
      );
    }

    return ElementHorizontalListview(
      elements: List<Episode>.from(episodes),
      entityId: widget.character.id.toString(),
      elementsIds: Utils.getIdsFromUrl(widget.character.episodes),
      loadNextPage: context.read<EpisodesByCharacterBloc>().loadEpisodes,
    );
  }
}
