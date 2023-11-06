import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/locations/locations.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

part 'search_locations_event.dart';
part 'search_locations_state.dart';

class SearchLocationsBloc
    extends Bloc<SearchLocationsEvent, SearchLocationsState> {
  final Future<List<Location>> Function(String) searchLocations;

  SearchLocationsBloc({
    required this.searchLocations,
  }) : super(const SearchLocationsState()) {
    on<SetQuery>(_setQuery);
    on<SetResults>(_setResults);
    on<SetQueryErrorMessage>(_setErrorMessage);
    on<SetLoading>(_setLoading);
  }

  void _setQuery(SetQuery event, Emitter<SearchLocationsState> emit) {
    emit(
      state.copyWith(
        query: event.query,
      ),
    );
  }

  void _setResults(SetResults event, Emitter<SearchLocationsState> emit) {
    emit(
      state.copyWith(
        results: event.results,
      ),
    );
  }

  void _setErrorMessage(
      SetQueryErrorMessage event, Emitter<SearchLocationsState> emit) {
    emit(
      state.copyWith(
        errorMessage: event.errorMsg,
      ),
    );
  }

  void _setLoading(SetLoading event, Emitter<SearchLocationsState> emit) {
    emit(
      state.copyWith(
        isLoading: event.value,
      ),
    );
  }

  Future<List<Location>> searchLocationsByQuery(String query) async {
    try {
      if (query == state.query && !state.isLoading) return state.results;

      if (query.isNotEmpty) add(SetLoading(true));

      add(SetQuery(query));

      final List<Location> locations = await searchLocations(query);

      add(SetLoading(false));
      add(SetQueryErrorMessage(''));

      if (query.isNotEmpty && locations.isEmpty) return state.results;

      add(SetResults(locations));

      return locations;
    } on LocationNotFound {
      add(SetResults([]));
      add(SetLoading(false));
      add(SetQueryErrorMessage("no_locations_by_name,$query"));

      return [];
    } on CustomError catch (e) {
      add(SetResults([]));
      add(SetLoading(false));
      add(SetQueryErrorMessage("error_search_result,${e.message}"));

      return [];
    } catch (e) {
      add(SetResults([]));
      add(SetLoading(false));
      add(SetQueryErrorMessage("unexpected_search_error"));

      return [];
    }
  }
}
