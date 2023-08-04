part of 'favorites_episodes_bloc.dart';

abstract class FavoritesEpisodesState {
  final Map<int, Episode> favoritesEpisodes;
  final int offset;
  final int limit;

  const FavoritesEpisodesState({
    required this.favoritesEpisodes,
    required this.offset,
    required this.limit,
  });
}

class FavoritesEpisodesInitial extends FavoritesEpisodesState {
  FavoritesEpisodesInitial({
    required Map<int, Episode> favoritesEpisodes,
    required int offset,
    required int limit,
  }) : super(
          favoritesEpisodes: favoritesEpisodes,
          offset: offset,
          limit: limit,
        );
}

class FavoritesEpisodesUpdate extends FavoritesEpisodesState {
  FavoritesEpisodesUpdate({
    required Map<int, Episode> favoritesEpisodes,
    required int offset,
    required int limit,
  }) : super(
          favoritesEpisodes: favoritesEpisodes,
          offset: offset,
          limit: limit,
        );
}
