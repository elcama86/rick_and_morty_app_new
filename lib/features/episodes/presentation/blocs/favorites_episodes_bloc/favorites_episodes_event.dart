part of 'favorites_episodes_bloc.dart';

abstract class FavoritesEpisodesEvent {}

class AddFavoriteEpisode extends FavoritesEpisodesEvent {
  final int episodeId;
  final Episode episode;

  AddFavoriteEpisode(this.episodeId, this.episode);
}

class RemoveFavoriteEpisode extends FavoritesEpisodesEvent {
  final int episodeId;

  RemoveFavoriteEpisode(this.episodeId);
}

class SetFavorites extends FavoritesEpisodesEvent {
  final Map<int, Episode> newFavorites;

  SetFavorites(this.newFavorites);
}

class SetShowIcon extends FavoritesEpisodesEvent {
  final bool value;

  SetShowIcon(this.value);
}

class ChangeIsFirstLoad extends FavoritesEpisodesEvent {
  final bool value;

  ChangeIsFirstLoad(this.value);
}

class SetTotalFavorites extends FavoritesEpisodesEvent {
  final int total;

  SetTotalFavorites(this.total);
}
