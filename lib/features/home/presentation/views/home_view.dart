import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            BlocBuilder<CharactersSlideCubit, CharactersSlideState>(
              builder: (context, state) {
                return _CharactersSlideShow(
                  characters: state.characters,
                );
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

class _CharactersSlideShow extends StatelessWidget {
  final List<Character> characters;

  const _CharactersSlideShow({
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 220.0,
      width: double.infinity,
      child: Swiper(
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
    return Padding(
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
    );
  }
}
