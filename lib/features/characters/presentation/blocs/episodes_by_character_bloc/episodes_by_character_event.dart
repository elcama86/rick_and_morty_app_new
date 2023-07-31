part of 'episodes_by_character_bloc.dart';

abstract class EpisodesByCharacterEvent {}

class SetIsLoading extends EpisodesByCharacterEvent {
  final bool isLoading;

  SetIsLoading(this.isLoading);
}

class SetNewCharacterEpisodes extends EpisodesByCharacterEvent {
  final String id;
  final List<Episode> episodes;
  final int totalEpisodes;
  final int loaded;

  SetNewCharacterEpisodes(
      this.id, this.episodes, this.totalEpisodes, this.loaded);
}

class SetNextEpisodes extends EpisodesByCharacterEvent {
  final String id;
  final List<Episode> episodes;
  final int loaded;

  SetNextEpisodes(this.id, this.episodes, this.loaded);
}

class SetHasError extends EpisodesByCharacterEvent {
  final bool hasError;

  SetHasError(this.hasError);
}
