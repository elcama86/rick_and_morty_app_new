import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';

class EpisodeSearchedItem extends StatelessWidget {
  final Episode episode;

  const EpisodeSearchedItem({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: GestureDetector(
        onTap: () => context.push('/episodes/episode/${episode.id}'),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _EpisodeCard(
                episode: episode,
              ),
              const SizedBox(
                width: 10.0,
              ),
              _EpisodeDetails(
                episode: episode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EpisodeDetails extends StatelessWidget {
  final Episode episode;

  const _EpisodeDetails({
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textThemes = Theme.of(context).textTheme;

    return SizedBox(
      width: size.width * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            episode.name,
            style: textThemes.titleMedium,
            textAlign: TextAlign.justify,
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.videocam_outlined),
            title: Text(
              episode.episode,
              style: textThemes.titleSmall,
              textAlign: TextAlign.justify,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.today_outlined),
            title: Text(
              EpisodeUtils.transformAirDate(episode.airDate),
              style: textThemes.titleSmall,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}

class _EpisodeCard extends StatelessWidget {
  final Episode episode;

  const _EpisodeCard({
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return SizedBox(
      width: size.width * 0.3,
      height: 165.0,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 30.0,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              colors.surfaceVariant,
              EpisodeUtils.colorBySeason(episode.episode),
            ]),
          ),
          child: Center(
            child: Text(
              'Episodio ${episode.id}',
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
