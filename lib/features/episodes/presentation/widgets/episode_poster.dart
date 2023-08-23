import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';

class EpisodePoster extends StatelessWidget {
  final Episode episode;

  const EpisodePoster({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;
    final random = Random();

    return FadeInUp(
      from: random.nextInt(100) + 50,
      delay: Duration(milliseconds: random.nextInt(300)),
      child: GestureDetector(
        onTap: () => context.push('/episodes/episode/${episode.id}'),
        child: Column(
          children: [
            _EpisodeCard(
              episode: episode,
            ),
            Text(
              episode.name,
              textAlign: TextAlign.center,
              style: textThemes.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _EpisodeCard extends StatelessWidget {
  const _EpisodeCard({
    required this.episode,
  });

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 180.0,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
          side: BorderSide(
            color: colors.outline,
          ),
        ),
        elevation: 5.0,
        child: _ChildCard(
          episode: episode,
        ),
      ),
    );
  }
}

class _ChildCard extends StatelessWidget {
  final Episode episode;

  const _ChildCard({
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textThemes = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.surfaceVariant,
            EpisodeUtils.colorBySeason(episode.episode),
          ],
          stops: const [0.2, 1.0],
        ),
      ),
      child: Center(
        child: Text(
          'Episodio ${episode.id}',
          textAlign: TextAlign.center,
          style: textThemes.titleMedium,
        ),
      ),
    );
  }
}
