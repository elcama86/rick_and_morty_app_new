import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

part 'search_episodes_event.dart';
part 'search_episodes_state.dart';

class SearchEpisodesBloc
    extends Bloc<SearchEpisodesEvent, SearchEpisodesState> {
  final Future<List<Episode>> Function(String query) searchEpisodes;

  SearchEpisodesBloc({
    required this.searchEpisodes,
  }) : super(const SearchEpisodesState()) {
    on<SetQueryValue>(_setQueryValue);
    on<SetQueryResults>(_setQueryResults);
    on<SetQueryErrorMessage>(_setQueryErrorMessage);
  }

  void _setQueryValue(SetQueryValue event, Emitter<SearchEpisodesState> emit) {
    emit(
      state.copyWith(
        query: event.query,
      ),
    );
  }

  void _setQueryResults(
      SetQueryResults event, Emitter<SearchEpisodesState> emit) {
    emit(
      state.copyWith(
        results: event.results,
      ),
    );
  }

  void _setQueryErrorMessage(
      SetQueryErrorMessage event, Emitter<SearchEpisodesState> emit) {
    emit(
      state.copyWith(
        errorMessage: event.message,
      ),
    );
  }

  Future<List<Episode>> searchEpisodesByQuery(String query) async {
    try {
      add(SetQueryValue(query));

      final List<Episode> results = await searchEpisodes(query);

      add(SetQueryResults(results));
      add(SetQueryErrorMessage(''));

      return results;
    } on EpisodeNotFound {
      add(SetQueryResults([]));
      add(SetQueryErrorMessage(
          "No se encontraron episodios con el nombre $query"));

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
