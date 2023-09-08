import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:rick_and_morty_app/config/config.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';

class CharactersSlideShow extends StatelessWidget {
  final List<Character> characters;

  const CharactersSlideShow({
    super.key,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return SizedBox(
      height: size.height * 0.35,
      width: double.infinity,
      child: characters.isEmpty
          ? Center(
              child: Text(
                AppLocalizations.of(context).translate("no_characters_found"),
                style: textStyle.titleLarge,
              ),
            )
          : Swiper(
              viewportFraction: 0.8,
              scale: 0.8,
              autoplay: true,
              pagination: SwiperPagination(
                margin: const EdgeInsets.only(top: 0.0),
                builder: DotSwiperPaginationBuilder(
                  activeColor: colors.primary,
                  color: colors.secondary,
                ),
              ),
              itemCount: characters.length,
              itemBuilder: (context, index) => _Slide(
                character: characters[index],
              ),
            ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Character character;

  const _Slide({
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black87,
          blurRadius: 10.0,
          offset: Offset(0, 10),
        ),
      ],
    );

    return GestureDetector(
      onTap: () => context.push(
        Uri(
          path: '/characters/character',
          queryParameters: {
            'id': '${character.id}',
            'name': character.name,
          },
        ).toString(),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: DecoratedBox(
          decoration: decoration,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(character.image),
              placeholder: const AssetImage("assets/images/cargando.gif"),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
