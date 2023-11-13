import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/characters/characters.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

part 'residents_by_location_event.dart';
part 'residents_by_location_state.dart';

class ResidentsByLocationBloc
    extends Bloc<ResidentsByLocationEvent, ResidentsByLocationState> {
  final Future<List<Character>> Function(List<String> ids)
      getResidentsByLocation;

  ResidentsByLocationBloc({
    required this.getResidentsByLocation,
  }) : super(const ResidentsByLocationState()) {
    on<SetLoadingResidents>(_setLoading);
    on<SetNewResidents>(_setNewResidents);
    on<SetNextResidents>(_setNextResidents);
    on<SetErrorLoading>(_setErrorLoading);
  }

  void _setLoading(
      SetLoadingResidents event, Emitter<ResidentsByLocationState> emit) {
    emit(
      state.copyWith(
        isLoading: event.value,
      ),
    );
  }

  void _setNewResidents(
      SetNewResidents event, Emitter<ResidentsByLocationState> emit) {
    emit(
      state.copyWith(
        residentsByLocation: {
          ...state.residentsByLocation,
          event.locationId: {
            'residents': event.residents,
            'totalResidents': event.totalResidents,
            'loaded': event.loaded,
          },
        },
      ),
    );
  }

  void _setNextResidents(
      SetNextResidents event, Emitter<ResidentsByLocationState> emit) {
    emit(
      state.copyWith(
        residentsByLocation: state.residentsByLocation.map(
          (key, value) {
            if (key == event.locationId) {
              return MapEntry(
                key,
                {
                  'residents': [...value['residents'], ...event.nextResidents],
                  'totalResidents': value['totalResidents'],
                  'loaded': event.loaded,
                },
              );
            }
            return MapEntry(key, value);
          },
        ),
      ),
    );
  }

  void _setErrorLoading(
      SetErrorLoading event, Emitter<ResidentsByLocationState> emit) {
    emit(
      state.copyWith(
        hasError: event.value,
      ),
    );
  }

  Future<void> _verifyResidentsByLocation(String id, List<String> ids) async {
    try {
      final loadedResidents = state.residentsByLocation[id]!['loaded'];

      if (loadedResidents == ids.length) {
        add(SetLoadingResidents(false));
        return;
      }

      int endIndex = SharedUtils.getEndIndex(loadedResidents, ids.length);

      final residents =
          await getResidentsByLocation(ids.sublist(loadedResidents, endIndex));

      add(SetNextResidents(id, residents, endIndex));
      add(SetLoadingResidents(false));
    } catch (e) {
      add(SetLoadingResidents(false));
      add(SetErrorLoading(true));
    }
  }

  Future<void> loadResidents(
      String locationId, List<String> residentsIds) async {
    try {
      if (state.isLoading && state.residentsByLocation[locationId] != null) {
        return;
      }

      add(SetLoadingResidents(true));
      add(SetErrorLoading(false));

      if (state.residentsByLocation[locationId] != null) {
        await _verifyResidentsByLocation(locationId, residentsIds);
        return;
      }

      final residents = residentsIds.length > 10
          ? await getResidentsByLocation(residentsIds.sublist(0, 10))
          : await getResidentsByLocation(residentsIds);

      add(SetNewResidents(
          locationId, residents, residentsIds.length, residents.length));
      add(SetLoadingResidents(false));
    } catch (e) {
      add(SetLoadingResidents(false));
      add(SetErrorLoading(true));
    }
  }
}
