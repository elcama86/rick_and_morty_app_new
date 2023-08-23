import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  const EpisodeCard({
    super.key,
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
        elevation: 5.0,
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
