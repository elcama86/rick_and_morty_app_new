import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

final episodeRepository = EpisodeRepositoryImpl(EpisodeDatasourceImpl());

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

class _EpisodesList extends StatelessWidget {
  final Character character;

  const _EpisodesList({
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final ids = Utils.getIdsFromUrl(character.episodes);
    final textStyle = Theme.of(context).textTheme.titleSmall;

    return FutureBuilder(
      future: episodeRepository.getEpisodesByList(ids),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 200.0,
            child: Center(
              child: LoadingSpinner(),
            ),
          );
        }

        if (snapshot.hasError) {
          return  SizedBox(
            height: 200.0,
            child: Center(
              child: Text('Los episodios no pudieron ser cargados', style: textStyle,),
            ),
          );
        }

        final episodes = snapshot.data ?? [];

        return Expanded(
          child: ListView.builder(
            itemCount: episodes.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return _Episode(
                episode: episodes[index],
              );
            },
          ),
        );
      },
    );
  }
}

class _Episode extends StatelessWidget {
  final Episode episode;

  const _Episode({
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleSmall;

    return GestureDetector(
      onTap: () => context.go('/episodes/episode/${episode.id}'),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 135.0,
        child: Column(
          children: [
            FadeInRight(
              child: EpisodeCard(
                episode: episode,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: Text(
                episode.name,
              
                textAlign: TextAlign.center,
                style: textStyle,
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
