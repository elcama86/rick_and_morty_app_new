import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:rick_and_morty_app/config/helpers/human_formats.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';
import 'package:rick_and_morty_app/features/shared/widgets/widgets.dart';

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
        vertical: 15.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              character.image,
              height: 200.0,
              width: size.width * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: SizedBox(
              width: (size.width - 0.4) * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    textAlign: TextAlign.justify,
                    style: textThemes.titleLarge,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  _CustomTextInfo(
                    title: "Estado",
                    text: character.status,
                    alignment: TextAlign.justify,
                  ),
                  _CustomTextInfo(
                    title: "Especie",
                    text: character.species,
                    alignment: TextAlign.justify,
                  ),
                  _CustomTextInfo(
                    title: "Tipo",
                    text: character.type,
                    alignment: TextAlign.justify,
                  ),
                  _CustomTextInfo(
                    title: "Género",
                    text: character.gender,
                    alignment: TextAlign.justify,
                  ),
                  _CustomTextInfo(
                    title: "Origen",
                    text: character.origin,
                    alignment: TextAlign.justify,
                  ),
                  _CustomTextInfo(
                    title: "Ubicación",
                    text: character.location,
                    alignment: TextAlign.justify,
                  ),
                  _CustomTextInfo(
                    title: "Creado",
                    text: HumanFormats.shortDate(character.created),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: RichText(
        textAlign: alignment,
        text: TextSpan(
          children: [
            TextSpan(
              text: "$title: ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: text.isEmpty ? "No especificado" : text,
            ),
          ],
        ),
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
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 0.0),
        title: CustomGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.7, 1.0],
          colors: [Colors.transparent, scaffoldBackgroundColor],
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                character.image,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();

                  return FadeIn(
                    child: child,
                  );
                },
              ),
            ),
            // Back button background
            const CustomGradient(
              begin: Alignment.topLeft,
              stops: [0.0, 0.3],
              colors: [
                Colors.black87,
                Colors.transparent,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

