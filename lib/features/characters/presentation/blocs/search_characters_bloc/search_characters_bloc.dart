import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

part 'search_characters_event.dart';
part 'search_characters_state.dart';

class SearchCharactersBloc
    extends Bloc<SearchCharactersEvent, SearchCharactersState> {
  final Future<List<Character>> Function(String query) searchCharacters;

  SearchCharactersBloc({
    required this.searchCharacters,
  }) : super(const SearchCharactersState()) {
    on<SetQueryValue>(_setQueryValue);
    on<SetQueryResults>(_setQueryResults);
    on<SetQueryErrorMessage>(_setQueryErrorMessage);
  }

  void _setQueryValue(
      SetQueryValue event, Emitter<SearchCharactersState> emit) {
    emit(
      state.copyWith(
        query: event.query,
      ),
    );
  }

  void _setQueryResults(
      SetQueryResults event, Emitter<SearchCharactersState> emit) {
    emit(
      state.copyWith(
        results: event.results,
      ),
    );
  }

  void _setQueryErrorMessage(
      SetQueryErrorMessage event, Emitter<SearchCharactersState> emit) {
    emit(
      state.copyWith(
        errorMessage: event.message,
      ),
    );
  }

  Future<List<Character>> searchCharactersByQuery(String query) async {
    try {
      add(SetQueryValue(query));

      final List<Character> results = await searchCharacters(query);

      add(SetQueryResults(results));
      add(SetQueryErrorMessage(''));

      return results;
    } on CharacterNotFound {
      add(SetQueryResults([]));
      add(SetQueryErrorMessage(
          "No se encontraron personajes con el nombre $query"));

      return [];
    } on CustomError catch (e) {
      add(SetQueryResults([]));
      add(SetQueryErrorMessage(
          "Ha ocurrido un error durante la búsqueda: ${e.message}"));

      return [];
    } catch (e) {
      add(SetQueryResults([]));
      add(SetQueryErrorMessage("Ocurrió un error inesperado"));

      return [];
    }
  }
}
