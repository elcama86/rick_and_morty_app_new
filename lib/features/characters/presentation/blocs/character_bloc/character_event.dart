part of 'character_bloc.dart';

abstract class CharacterEvent {}

class SetCharacter extends CharacterEvent {
  final String id;
  final Character character;

  SetCharacter(this.id, this.character);
}

class SetCharacterErrorMessage extends CharacterEvent {
  final String message;

  SetCharacterErrorMessage(this.message);
}
