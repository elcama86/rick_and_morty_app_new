import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/presentation/widgets/widgets.dart';

class EpisodeView extends StatelessWidget {
  final Episode episode;

  const EpisodeView({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(
          episode: episode,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _EpisodeDetails(
              episode: episode,
            ),
            childCount: 1,
          ),
        ),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Episode episode;

  const _CustomSliverAppBar({
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textStyle = Theme.of(context).textTheme.titleLarge;

    return SliverAppBar(
      expandedHeight: size.height * 0.3,
      backgroundColor: scaffoldBackgroundColor,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_outline,
            color: Colors.red,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 0.0),
        title: TitleSliverAppBar(
          title: 'Episodio ${episode.id}',
          textStyle: textStyle,
          gradientColor: scaffoldBackgroundColor,
          bottom: 10.0,
          left: 60.0,
        ),
        background: Stack(
          children: [
            CustomGradient(
              colors: [
                colors.surfaceVariant,
                EpisodeUtils.colorBySeason(episode.episode)
              ],
              stops: const [0.2, 1.0],
            ),
            const CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [
                Colors.black54,
                Colors.transparent,
              ],
            ),
          ],
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
        const SizedBox(
          height: 20.0,
        ),
        ElementsByEntity(
          title: 'Personajes que aparecen en este episodio',
          entity: episode,
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
