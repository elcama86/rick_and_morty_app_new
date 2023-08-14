import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rick_and_morty_app/features/characters/domain/domain.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final Future<List<Character>> Function({int page}) getCharactersByPage;

  CharactersBloc({
    required this.getCharactersByPage,
  }) : super(const CharactersState()) {
    on<SetCharacters>(_setCharacters);
    on<SetLoadingCharacters>(_setLoadingCharacters);
    on<SetIsLastPage>(_setIsLastPage);
    on<ChangePage>(_changePage);
    on<SetErrorMessage>(_setErrorMessage);
  }

  void _setCharacters(SetCharacters event, Emitter<CharactersState> emit) {
    emit(
      state.copyWith(
        characters: [...state.characters, ...event.characters],
      ),
    );
  }

  void _setLoadingCharacters(
      SetLoadingCharacters event, Emitter<CharactersState> emit) {
    emit(
      state.copyWith(
        isLoading: event.value,
      ),
    );
  }

  void _setIsLastPage(SetIsLastPage event, Emitter<CharactersState> emit) {
    emit(
      state.copyWith(
        isLastPage: event.value,
      ),
    );
  }

  void _changePage(ChangePage event, Emitter<CharactersState> emit) {
    emit(
      state.copyWith(
        page: event.newPage,
      ),
    );
  }

  void _setErrorMessage(SetErrorMessage event, Emitter<CharactersState> emit) {
    emit(
      state.copyWith(
        errorMessage: event.message,
      ),
    );
  }

  Future<void> loadNextPage() async {
    try {
      if (state.isLoading || state.isLastPage) return;
      add(SetLoadingCharacters(true));
      add(SetErrorMessage(''));

      await Future.delayed(const Duration(milliseconds: 500));

      final characters = await getCharactersByPage(page: state.page);

      add(SetLoadingCharacters(false));
      add(SetIsLastPage(false));
      add(ChangePage(state.page + 1));
      add(SetCharacters(characters));
    } on CharacterNotFound {
      add(SetLoadingCharacters(false));
      add(SetIsLastPage(true));
    } on CustomError catch (e) {
      add(SetLoadingCharacters(false));
      add(SetErrorMessage(e.message));
    } catch (e) {
      add(SetLoadingCharacters(false));
      add(SetErrorMessage('Ha ocurrido un error inesperado'));
    }
  }
}
