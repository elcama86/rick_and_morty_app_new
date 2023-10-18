import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class EpisodePoster extends StatelessWidget {
  final Episode episode;

  const EpisodePoster({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return FadeInUp(
      from: random.nextInt(100) + 50,
      delay: Duration(milliseconds: random.nextInt(300)),
      child: _EpisodePosterContain(
        episode: episode,
      ),
    );
  }
}

class _EpisodePosterContain extends StatefulWidget {
  final Episode episode;

  const _EpisodePosterContain({
    required this.episode,
  });

  @override
  State<_EpisodePosterContain> createState() => _EpisodePosterContainState();
}

class _EpisodePosterContainState extends State<_EpisodePosterContain> {
  late AnimationController controller;

  void _removeFavorite() {
    controller.reset();
    controller.forward().then(
          (_) => context
              .read<FavoritesEpisodesBloc>()
              .toggleFavorite(widget.episode)
              .then((_) {
            final totalFavorites =
                context.read<FavoritesEpisodesBloc>().state.totalFavorites;

            context
                .read<BottomNavBarCubit>()
                .updateFavoritesPosition(totalFavorites);

            SharedUtils.showSnackbar(context, 'episode,${widget.episode.id},episode_deleted');
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        final currentIndex = state.currentIndex;

        return GestureDetector(
          onTap: () => context.push('/episodes/episode/${widget.episode.id}'),
          onLongPress: currentIndex == 1 ? _removeFavorite : null,
          child: currentIndex == 1
              ? ShakeX(
                  manualTrigger: true,
                  controller: (animationCtrl) => controller = animationCtrl,
                  duration: const Duration(milliseconds: 500),
                  child: _EpisodePosterColumn(
                    key: ValueKey<int>(widget.episode.id),
                    episode: widget.episode,
                  ),
                )
              : _EpisodePosterColumn(
                  episode: widget.episode,
                ),
        );
      },
    );
  }
}

class _EpisodePosterColumn extends StatelessWidget {
  final Episode episode;

  const _EpisodePosterColumn({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    final textThemes = Theme.of(context).textTheme;

    return Column(
      children: [
        _EpisodePosterCard(
          episode: episode,
        ),
        Text(
          episode.name,
          textAlign: TextAlign.center,
          style: textThemes.titleSmall,
        ),
      ],
    );
  }
}

class _EpisodePosterCard extends StatelessWidget {
  const _EpisodePosterCard({
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
          '${AppLocalizations.of(context).translate('episode')} ${episode.id}',
          textAlign: TextAlign.center,
          style: textThemes.titleMedium,
        ),
      ),
    );
  }
}
