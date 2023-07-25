part of 'search_characters_bloc.dart';

abstract class SearchCharactersEvent {}

class SetQueryValue extends SearchCharactersEvent {
  final String query;

  SetQueryValue(this.query);
}

class SetQueryResults extends SearchCharactersEvent {
  final List<Character> results;

  SetQueryResults(this.results);
}

class SetQueryErrorMessage extends SearchCharactersEvent {
  final String message;

  SetQueryErrorMessage(this.message);
}
