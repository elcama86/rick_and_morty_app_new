part of 'residents_by_location_bloc.dart';

abstract class ResidentsByLocationEvent {}

class SetLoadingResidents extends ResidentsByLocationEvent {
  final bool value;

  SetLoadingResidents(this.value);
}

class SetNewResidents extends ResidentsByLocationEvent {
  final String locationId;
  final List<Character> residents;
  final int totalResidents;
  final int loaded;

  SetNewResidents(
    this.locationId,
    this.residents,
    this.totalResidents,
    this.loaded,
  );
}

class SetNextResidents extends ResidentsByLocationEvent {
  final String locationId;
  final List<Character> nextResidents;
  final int loaded;

  SetNextResidents(
    this.locationId,
    this.nextResidents,
    this.loaded,
  );
}

class SetErrorLoading extends ResidentsByLocationEvent {
  final bool value;

  SetErrorLoading(this.value);
}
