import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

part 'characters_slide_state.dart';

class CharactersSlideCubit extends Cubit<CharactersSlideState> {
  final Future<List<Character>> Function(List<String> ids) getCharactersByIds;

  CharactersSlideCubit({
    required this.getCharactersByIds,
  }) : super(const CharactersSlideState());

  List<String> idsList() {
    Random random = Random();

    List<String> ids = <String>[];

    do {
      String id = random.nextInt(827).toString();
      if (!ids.contains(id)) {
        ids.add(id);
      }
    } while (ids.length < 6);

    return ids;
  }

  Future<void> getCharactersSlide() async {
    try {
      if (state.isRetrying) return;

      if (state.errorMessage.isNotEmpty) {
        emit(
          state.copyWith(
            isRetrying: true,
          ),
        );
      }

      await Future.delayed(const Duration(milliseconds: 500));

      final characters = await getCharactersByIds(idsList());

      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: '',
          isRetrying: false,
          characters: characters,
        ),
      );
    } on CustomError catch (e) {
       emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.message,
          isRetrying: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'unexpected_error',
          isRetrying: false,
        ),
      );
    }
  }
}
