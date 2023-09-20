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
    on<SetQueryLoading>(_setQueryLoading);
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

  void _setQueryLoading(
      SetQueryLoading event, Emitter<SearchCharactersState> emit) {
    emit(
      state.copyWith(
        isLoading: event.value,
      ),
    );
  }

  Future<List<Character>> searchCharactersByQuery(String query) async {
    try {
      if (query == state.query && !state.isLoading) return state.results;

      if (query.isNotEmpty) add(SetQueryLoading(true));

      add(SetQueryValue(query));

      final List<Character> results = await searchCharacters(query);

      add(SetQueryLoading(false));
      add(SetQueryErrorMessage(''));

      if (query.isNotEmpty && results.isEmpty) return state.results;

      add(SetQueryResults(results));

      return results;
    } on CharacterNotFound {
      add(SetQueryResults([]));
      add(SetQueryLoading(false));
      add(SetQueryErrorMessage("no_characters_by_name,$query"));

      return [];
    } on CustomError catch (e) {
      add(SetQueryResults([]));
      add(SetQueryLoading(false));
      add(SetQueryErrorMessage("error_search_result,${e.message}"));

      return [];
    } catch (e) {
      add(SetQueryResults([]));
      add(SetQueryLoading(false));
      add(SetQueryErrorMessage("unexpected_search_error"));

      return [];
    }
  }
}
