part of 'search_locations_bloc.dart';

abstract class SearchLocationsEvent {}

class SetQuery extends SearchLocationsEvent {
  final String query;

  SetQuery(this.query);
}

class SetResults extends SearchLocationsEvent {
  final List<Location> results;

  SetResults(this.results);
}

class SetQueryErrorMessage extends SearchLocationsEvent {
  final String errorMsg;

  SetQueryErrorMessage(this.errorMsg);
}

class SetLoading extends SearchLocationsEvent {
  final bool value;

  SetLoading(this.value);
}
