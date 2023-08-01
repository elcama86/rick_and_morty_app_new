part of 'characters_by_episode_bloc.dart';

abstract class CharactersByEpisodeEvent {}

class SetIsLoading extends CharactersByEpisodeEvent {
  final bool value;

  SetIsLoading(this.value);
}

class SetNewEpisodeCharacters extends CharactersByEpisodeEvent {
  final String episodeId;
  final List<Character> characters;
  final int totalCharacters;
  final int loaded;

  SetNewEpisodeCharacters(
      this.episodeId, this.characters, this.totalCharacters, this.loaded);
}

class SetNextCharacters extends CharactersByEpisodeEvent {
  final String episodeId;
  final List<Character> nextCharacters;
  final int loaded;

  SetNextCharacters(this.episodeId, this.nextCharacters, this.loaded);
}

class SetHasError extends CharactersByEpisodeEvent {
  final bool value;

  SetHasError(this.value);
}
