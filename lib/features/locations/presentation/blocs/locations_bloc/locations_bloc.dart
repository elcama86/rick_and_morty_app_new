import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/locations/locations.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

part 'locations_event.dart';
part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final Future<List<Location>> Function({int page}) getLocationsByPage;

  LocationsBloc({
    required this.getLocationsByPage,
  }) : super(const LocationsState()) {
    on<SetLoadingLocations>(_setLoadingLocations);
    on<SetIsLastPage>(_setIsLastPage);
    on<SetPage>(_setPage);
    on<SetLocations>(_setLocations);
    on<SetErrorMessage>(_setErrorMessage);
    loadNextPage();
  }

  void _setLoadingLocations(
      SetLoadingLocations event, Emitter<LocationsState> emit) {
    emit(
      state.copyWith(
        isLoading: event.value,
      ),
    );
  }

  void _setIsLastPage(SetIsLastPage event, Emitter<LocationsState> emit) {
    emit(
      state.copyWith(
        isLastPage: event.value,
      ),
    );
  }

  void _setPage(SetPage event, Emitter<LocationsState> emit) {
    emit(
      state.copyWith(
        page: event.page,
      ),
    );
  }

  void _setLocations(SetLocations event, Emitter<LocationsState> emit) {
    emit(
      state.copyWith(
        locations: [...state.locations, ...event.locations],
      ),
    );
  }

  void _setErrorMessage(SetErrorMessage event, Emitter<LocationsState> emit) {
    emit(
      state.copyWith(
        errorMessage: event.message,
      ),
    );
  }

  Future<void> loadNextPage() async {
    try {
      if (state.isLoading || state.isLastPage) return;

      add(SetLoadingLocations(true));
      add(SetErrorMessage(''));

      await Future.delayed(const Duration(milliseconds: 500));

      final locations = await getLocationsByPage(page: state.page);

      add(SetLocations(locations));

      add(SetPage(state.page + 1));
      add(SetIsLastPage(false));
      add(SetLoadingLocations(false));
    } on LocationNotFound {
      add(SetIsLastPage(true));
      add(SetLoadingLocations(false));
    } on CustomError catch (e) {
      add(SetErrorMessage(e.message));
      add(SetLoadingLocations(false));
    } catch (e) {
      add(SetErrorMessage('unexpected_error'));
      add(SetLoadingLocations(false));
    }
  }
}
