part of 'episodes_bloc.dart';

abstract class EpisodesEvent {}

class SetEpisodes extends EpisodesEvent {
  final List<Episode> episodes;

  SetEpisodes(this.episodes);
}

class SetLoadingEpisodes extends EpisodesEvent {
  final bool value;

  SetLoadingEpisodes(this.value);
}

class SetIsLastPage extends EpisodesEvent {
  final bool value;

  SetIsLastPage(this.value);
}

class ChangePage extends EpisodesEvent {
  final int page;

  ChangePage(this.page);
}

class SetErrorMessage extends EpisodesEvent {
  final String message;

  SetErrorMessage(this.message);
}
