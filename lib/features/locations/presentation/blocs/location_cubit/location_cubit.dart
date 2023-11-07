import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/locations/domain/domain.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final Future<Location> Function(String id) getLocationById;

  LocationCubit({
    required this.getLocationById,
  }) : super(const LocationState());

  void _setErrorMessage(String errorMessage) {
    emit(
      state.copyWith(
        errorMessage: errorMessage,
      ),
    );
  }

  void _setLocation(String id, Location location) {
    emit(
      state.copyWith(
        locationsMap: {...state.locationsMap, id: location},
      ),
    );
  }

  Future<void> getLocation(String id) async {
    try {
      if (state.locationsMap[id] != null) return;

      _setErrorMessage('');

      await Future.delayed(const Duration(milliseconds: 500));

      final location = await getLocationById(id);

      _setLocation(id, location);
    } on LocationNotFound {
      _setErrorMessage('location_id_message,$id');
    } on CustomError catch (e) {
      _setErrorMessage(e.message);
    } catch (e) {
      _setErrorMessage('unexpected_error');
    }
  }
}
