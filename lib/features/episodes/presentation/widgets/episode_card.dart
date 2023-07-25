import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  const EpisodeCard({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textThemes = Theme.of(context).textTheme;

    return FadeInUp(
      child: GestureDetector(
        onTap: () => context.push('/episodes/episode/${episode.id}'),
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
          elevation: 30.0,
          child: _ChildCard(
            colors: colors,
            episode: episode,
            textThemes: textThemes,
          ),
        ),
      ),
    );
  }
}

class _ChildCard extends StatelessWidget {
  final ColorScheme colors;
  final Episode episode;
  final TextTheme textThemes;

  const _ChildCard({
    required this.colors,
    required this.episode,
    required this.textThemes,
  });

  @override
  Widget build(BuildContext context) {
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          children: [
            _Header(
              title: 'Episodio ${episode.id}',
              textStyle: textThemes.titleLarge,
            ),
            const SizedBox(
              height: 10.0,
            ),
            _ItemCard(
              text: episode.name,
              textStyle: textThemes.titleMedium,
              alignment: Alignment.bottomLeft,
            ),
            const SizedBox(
              height: 10.0,
            ),
            _ItemCard(
              text: EpisodeUtils.transformAirDate(episode.airDate),
              textStyle: textThemes.titleMedium,
              alignment: Alignment.bottomRight,
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Alignment alignment;

  const _ItemCard({
    required this.text,
    this.textStyle,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: alignment,
        child: Text(
          text,
          style: textStyle,
        ));
  }
}

class _Header extends StatelessWidget {
  final String title;
  final TextStyle? textStyle;

  const _Header({
    required this.title,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textStyle,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_border_outlined,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
