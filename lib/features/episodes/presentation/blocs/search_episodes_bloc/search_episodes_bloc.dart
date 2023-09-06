import 'dart:async';

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
    on<SetQueryLoading>(_setQueryLoading);
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

  void _setQueryLoading(
      SetQueryLoading event, Emitter<SearchEpisodesState> emit) {
    emit(
      state.copyWith(
        isLoading: event.value,
      ),
    );
  }

  Future<List<Episode>> searchEpisodesByQuery(String query) async {
    try {
      if (query != state.query) add(SetQueryLoading(true));

      add(SetQueryValue(query));

      final List<Episode> results = await searchEpisodes(query);

      add(SetQueryResults(results));
      add(SetQueryLoading(false));
      add(SetQueryErrorMessage(''));

      return results;
    } on EpisodeNotFound {
      add(SetQueryResults([]));
      add(SetQueryLoading(false));
      add(SetQueryErrorMessage("no_episodes_by_name,$query"));

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
