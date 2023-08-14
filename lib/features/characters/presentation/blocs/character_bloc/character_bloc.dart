import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final Future<Character> Function(String) getCharacterById;

  CharacterBloc({
    required this.getCharacterById,
  }) : super(const CharacterState()) {
    on<SetCharacter>(_setCharacter);
    on<SetCharacterErrorMessage>(_setCharacterErrorMessage);
  }

  void _setCharacter(SetCharacter event, Emitter<CharacterState> emit) {
    emit(
      state.copyWith(
        charactersMap: {...state.charactersMap, event.id: event.character},
      ),
    );
  }

  void _setCharacterErrorMessage(
      SetCharacterErrorMessage event, Emitter<CharacterState> emit) {
    emit(state.copyWith(
      errorMessage: event.message,
    ));
  }

  Future<void> getCharacter(String id) async {
    try {
      if (state.charactersMap[id] != null) return;
      add(SetCharacterErrorMessage(''));

      await Future.delayed(const Duration(milliseconds: 500));

      final character = await getCharacterById(id);

      add(SetCharacter(id, character));
    } on CharacterNotFound {
      add(SetCharacterErrorMessage('Personaje con id: $id no existe'));
    } on CustomError catch (e) {
      add(SetCharacterErrorMessage(e.message));
    } catch (e) {
      add(SetCharacterErrorMessage('Ha ocurrido un error inesperado'));
    }
  }
}
