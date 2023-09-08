import 'dart:math';

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';

class CharacterPoster extends StatelessWidget {
  final Character character;

  const CharacterPoster({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final random = Random();

    return FadeInUp(
      from: random.nextInt(100) + 80,
      delay: Duration(milliseconds: random.nextInt(450) + 0),
      child: GestureDetector(
        onTap: () => context.push(
          Uri(
            path: '/characters/character',
            queryParameters: {
              'id': '${character.id}',
              'name': character.name,
            },
          ).toString(),
        ),
        child: Column(
          children: [
            _CharacterImage(
              imageUrl: character.image,
            ),
            Text(
              character.name,
              textAlign: TextAlign.center,
              style: textStyles.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _CharacterImage extends StatelessWidget {
  final String imageUrl;

  const _CharacterImage({
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: FadeInImage(
        height: 180.0,
        fit: BoxFit.fill,
        placeholder: const AssetImage('assets/images/cargando.gif'),
        image: NetworkImage(
          imageUrl,
        ),
      ),
    );
  }
}
