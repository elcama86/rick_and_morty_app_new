part of 'favorites_episodes_bloc.dart';

abstract class FavoritesEpisodesState {
  final Map<int, Episode> favoritesEpisodes;
  final int offset;
  final int limit;
  final bool showIcon;

  const FavoritesEpisodesState({
    required this.favoritesEpisodes,
    required this.offset,
    required this.limit,
    required this.showIcon,
  });
}

class FavoritesEpisodesInitial extends FavoritesEpisodesState {
  FavoritesEpisodesInitial({
    required Map<int, Episode> favoritesEpisodes,
    required int offset,
    required int limit,
    required bool showIcon,
  }) : super(
          favoritesEpisodes: favoritesEpisodes,
          offset: offset,
          limit: limit,
          showIcon: showIcon,
        );
}

class FavoritesEpisodesUpdate extends FavoritesEpisodesState {
  FavoritesEpisodesUpdate({
    required Map<int, Episode> favoritesEpisodes,
    required int offset,
    required int limit,
    required bool showIcon,
  }) : super(
          favoritesEpisodes: favoritesEpisodes,
          offset: offset,
          limit: limit,
          showIcon: showIcon,
        );
}
