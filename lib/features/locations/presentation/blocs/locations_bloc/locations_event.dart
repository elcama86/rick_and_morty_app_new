part of 'locations_bloc.dart';

abstract class LocationsEvent {}

class SetLoadingLocations extends LocationsEvent {
  final bool value;

  SetLoadingLocations(this.value);
}

class SetIsLastPage extends LocationsEvent {
  final bool value;

  SetIsLastPage(this.value);
}

class SetPage extends LocationsEvent {
  final int page;

  SetPage(this.page);
}

class SetLocations extends LocationsEvent {
  final List<Location> locations;

  SetLocations(this.locations);
}

class SetErrorMessage extends LocationsEvent {
  final String message;

  SetErrorMessage(this.message);
}
