import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';

part 'characters_slide_state.dart';

class CharactersSlideCubit extends Cubit<CharactersSlideState> {
  final Future<List<Character>> Function(List<String> ids) getCharactersByIds;

  CharactersSlideCubit({
    required this.getCharactersByIds,
  }) : super(const CharactersSlideState());

  Future<void> getCharactersSlide() async {
    try {
      Random random = Random();

      List<String> ids = List<String>.generate(
        6,
        (_) => random.nextInt(826).toString(),
      );

      final characters = await getCharactersByIds(ids);

      emit(
        state.copyWith(
          isLoading: false,
          hasError: false,
          characters: characters,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
        ),
      );
    }
  }
}
