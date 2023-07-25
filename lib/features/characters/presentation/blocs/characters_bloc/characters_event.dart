part of 'characters_bloc.dart';

abstract class CharactersEvent {}

class SetCharacters extends CharactersEvent {
  final List<Character> characters;

  SetCharacters(this.characters);
}

class SetLoadingCharacters extends CharactersEvent {
  final bool value;

  SetLoadingCharacters(this.value);
}

class SetIsLastPage extends CharactersEvent {
  final bool value;

  SetIsLastPage(this.value);
}

class ChangePage extends CharactersEvent {
  final int newPage;

  ChangePage(this.newPage);
}

class SetErrorMessage extends CharactersEvent {
  final String message;

  SetErrorMessage(this.message);
}
