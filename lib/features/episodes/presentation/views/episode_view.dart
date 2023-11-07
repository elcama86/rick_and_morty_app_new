import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/settings/settings.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

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
      actions: [
        IconButton(
          onPressed: () async {
            await context.read<FavoritesEpisodesBloc>().toggleFavorite(episode);
          },
          icon: FutureBuilder(
            future:
                context.read<FavoritesEpisodesBloc>().isFavorite(episode.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }

              return BlocBuilder<FavoritesEpisodesBloc, FavoritesEpisodesState>(
                builder: (context, state) {
                  final isFavorite = state.showIcon;

                  return FadeIn(
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_outline,
                      color: Colors.red,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 0.0),
        title: TitleSliverAppBar(
          title:
              '${AppLocalizations.of(context).translate('episode')} ${episode.id}',
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
        ItemToShow(
          title: 'name',
          subtitle: episode.name,
          icon: Icons.video_label_outlined,
        ),
        ItemToShow(
          title: 'season',
          subtitle: EpisodeUtils.getSeason(episode.episode),
          icon: Icons.videocam_outlined,
        ),
        ItemToShow(
          title: 'episode_number',
          subtitle: EpisodeUtils.getEpisode(episode.episode),
        ),
        ItemToShow(
          title: 'air_date',
          subtitle: context.select(
            (SettingsCubit settingsCubit) => EpisodeUtils.transformAirDate(
              episode.airDate,
              settingsCubit.state.language,
            ),
          ),
          icon: Icons.today_outlined,
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElementsByEntity(
          title: 'characters_appear',
          entity: episode,
        ),
      ],
    );
  }
}
