import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  const CharacterCard({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.3,
      height: 165.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FadeInImage(
          height: 165.0,
          fit: BoxFit.fill,
          placeholder: const AssetImage('assets/images/cargando.gif'),
          image: NetworkImage(
            character.image,
          ),
        ),
      ),
    );
  }
}
