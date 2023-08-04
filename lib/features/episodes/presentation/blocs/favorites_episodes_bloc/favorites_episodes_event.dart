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