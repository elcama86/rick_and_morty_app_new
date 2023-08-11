import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

import '../widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackground(
      child: Column(
        mainAxisAlignment: context.select((CharactersSlideCubit charactersSlideCubit) => charactersSlideCubit.state.characters.isNotEmpty ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start),
        children: [
          const SizedBox(
            height: 20.0,
          ),
          BlocBuilder<CharactersSlideCubit, CharactersSlideState>(
            builder: (context, state) {
              return CharactersSlideShow(
                characters: state.characters,
              );
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          const TrailerVideo(),
          const SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
