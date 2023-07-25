import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';

class EpisodeView extends StatelessWidget {
  final Episode episode;

  const EpisodeView({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ItemToShow(
          title: 'Nombre',
          subtitle: episode.name,
          icon: Icons.video_label_outlined,
        ),
        _ItemToShow(
          title: 'Temporada',
          subtitle: EpisodeUtils.getSeason(episode.episode),
          icon: Icons.videocam_outlined,
        ),
        _ItemToShow(
          title: 'Número de episodio',
          subtitle: EpisodeUtils.getEpisode(episode.episode),
        ),
        _ItemToShow(
          title: 'Fecha de emisión',
          subtitle: EpisodeUtils.transformAirDate(episode.airDate),
          icon: Icons.today_outlined,
        ),
      ],
    );
  }
}

class _ItemToShow extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;

  const _ItemToShow({
    required this.title,
    required this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;

    return ListTile(
      leading: icon != null
          ? Icon(
              icon,
            )
          : const SizedBox(),
      title: Text(
        title,
        style: textThemes.titleMedium,
      ),
      subtitle: Text(
        subtitle,
        style: textThemes.titleSmall,
      ),
    );
  }
}
