import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';

class CharacterSearchedItem extends StatelessWidget {
  final Character character;

  const CharacterSearchedItem({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textThemes = Theme.of(context).textTheme;

    return FadeIn(
      child: GestureDetector(
        onTap: () => context.push('/characters/character/${character.id}'),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage(
                    height: 150.0,
                    placeholder: const AssetImage('assets/images/cargando.gif'),
                    image: NetworkImage(character.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                width: size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: textThemes.titleMedium,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    _InfoWithIcon(
                      info: CharacterUtils.getStatus(character.status),
                      icon: Icons.monitor_heart_outlined,
                    ),
                    _InfoWithIcon(
                      info: CharacterUtils.getSpecies(character.species),
                      icon: Icons.hourglass_empty,
                    ),
                    _InfoWithIcon(
                      info: CharacterUtils.getGender(character.gender),
                      icon: Icons.wc,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoWithIcon extends StatelessWidget {
  const _InfoWithIcon({
    required this.info,
    required this.icon,
  });

  final String info;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.titleSmall;

    return Row(
      children: [
        Icon(
          icon,
          size: 18.0,
        ),
        const SizedBox(
          width: 5.0,
        ),
        Text(
          AppLocalizations.of(context).translate(info).isEmpty
              ? info
              : AppLocalizations.of(context).translate(info),
          style: textTheme,
        ),
      ],
    );
  }
}
