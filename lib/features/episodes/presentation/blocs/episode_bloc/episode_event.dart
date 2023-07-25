part of 'episode_bloc.dart';

abstract class EpisodeEvent {}

class SetEpisode extends EpisodeEvent {
  final String id;
  final Episode episode;

  SetEpisode(this.id, this.episode);
}

class SetEpisodeErrorMessage extends EpisodeEvent {
  final String message;

  SetEpisodeErrorMessage(this.message);
}
