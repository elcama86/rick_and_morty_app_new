import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/settings/settings.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class CharacterView extends StatelessWidget {
  final Character character;

  const CharacterView({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        _CustomSliverAppBar(
          character: character,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _CharacterDetails(
              character: character,
            ),
            childCount: 1,
          ),
        ),
      ],
    );
  }
}

class _CharacterDetails extends StatelessWidget {
  final Character character;

  const _CharacterDetails({
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textThemes = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BasicInfo(
          character: character,
          size: size,
          textThemes: textThemes,
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElementsByEntity(
          title: "episodes_appears",
          entity: character,
        ),
      ],
    );
  }
}

class _BasicInfo extends StatelessWidget {
  final Character character;
  final Size size;
  final TextTheme textThemes;

  const _BasicInfo({
    required this.character,
    required this.size,
    required this.textThemes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 20.0,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: CachedNetworkImageProvider(
                character.image,
              ),
              height: 210.0,
              width: size.width * 0.3,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: SizedBox(
              width: (size.width - 0.5) * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CustomTextInfo(
                    title: "status",
                    text: character.status,
                    alignment: TextAlign.justify,
                  ),
                  _CustomTextInfo(
                    title: "species",
                    text: character.species,
                    alignment: TextAlign.justify,
                  ),
                  _CustomTextInfo(
                    title: "type",
                    text: character.type,
                    alignment: TextAlign.justify,
                  ),
                  _CustomTextInfo(
                    title: "gender",
                    text: character.gender,
                    alignment: TextAlign.justify,
                  ),
                  _CustomTextInfo(
                    title: "origin",
                    text: character.origin,
                    alignment: TextAlign.justify,
                  ),
                  _CustomTextInfo(
                    title: "location",
                    text: character.location,
                    alignment: TextAlign.justify,
                  ),
                  _CustomTextInfo(
                    title: "created",
                    text: context.select(
                      (SettingsCubit settingsCubit) => HumanFormats.shortDate(
                        character.created,
                        settingsCubit.state.language,
                      ),
                    ),
                    alignment: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomTextInfo extends StatelessWidget {
  final String title;
  final String text;
  final TextAlign alignment;

  const _CustomTextInfo({
    required this.title,
    required this.text,
    this.alignment = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleSmall;

    return RichText(
      textAlign: alignment,
      textScaleFactor: 0.9,
      text: TextSpan(
        style: textStyle,
        children: [
          TextSpan(
            text: "${AppLocalizations.of(context).translate(title)}: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: AppLocalizations.of(context)
                    .translate(CharacterUtils.getValue(title, text))
                    .isEmpty
                ? CharacterUtils.getValue(title, text)
                : AppLocalizations.of(context)
                    .translate(CharacterUtils.getValue(title, text)),
          ),
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Character character;

  const _CustomSliverAppBar({
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textStyle = Theme.of(context).textTheme.titleLarge;

    return SliverAppBar(
      backgroundColor: scaffoldBackgroundColor,
      expandedHeight: size.height * 0.7,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 0.0),
        title: TitleSliverAppBar(
          title: character.name,
          textStyle: textStyle,
          gradientColor: scaffoldBackgroundColor,
          bottom: 10.0,
          left: 60.0,
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image(
                image: CachedNetworkImageProvider(
                  character.image,
                ),
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();

                  return FadeIn(
                    child: child,
                  );
                },
              ),
            ),
            // Back button background
            CustomGradient(
              begin: Alignment.topLeft,
              stops: const [0.0, 0.4],
              colors: [
                colors.background,
                Colors.transparent,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
