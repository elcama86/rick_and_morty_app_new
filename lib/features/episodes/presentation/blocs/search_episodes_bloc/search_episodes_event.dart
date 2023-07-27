part of 'search_episodes_bloc.dart';

abstract class SearchEpisodesEvent {}

class SetQueryValue extends SearchEpisodesEvent {
  final String query;

  SetQueryValue(this.query);
}

class SetQueryResults extends SearchEpisodesEvent {
  final List<Episode> results;

  SetQueryResults(this.results);
}

class SetQueryErrorMessage extends SearchEpisodesEvent {
  final String message;

  SetQueryErrorMessage(this.message);
}
