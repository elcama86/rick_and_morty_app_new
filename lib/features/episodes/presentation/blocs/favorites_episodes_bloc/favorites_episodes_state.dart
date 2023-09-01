part of 'favorites_episodes_bloc.dart';

abstract class FavoritesEpisodesState {
  final Map<int, Episode> favoritesEpisodes;
  final int offset;
  final int limit;
  final bool showIcon;
  final bool isFirstLoad;

  const FavoritesEpisodesState({
    required this.favoritesEpisodes,
    required this.offset,
    required this.limit,
    required this.showIcon,
    required this.isFirstLoad,
  });
}

class FavoritesEpisodesInitial extends FavoritesEpisodesState {
  FavoritesEpisodesInitial({
    required Map<int, Episode> favoritesEpisodes,
    required int offset,
    required int limit,
    required bool showIcon,
    required bool isFirstLoad,
  }) : super(
          favoritesEpisodes: favoritesEpisodes,
          offset: offset,
          limit: limit,
          showIcon: showIcon,
          isFirstLoad: isFirstLoad,
        );
}

class FavoritesEpisodesUpdate extends FavoritesEpisodesState {
  FavoritesEpisodesUpdate({
    required Map<int, Episode> favoritesEpisodes,
    required int offset,
    required int limit,
    required bool showIcon,
    required isFirstLoad,
  }) : super(
          favoritesEpisodes: favoritesEpisodes,
          offset: offset,
          limit: limit,
          showIcon: showIcon,
          isFirstLoad: isFirstLoad,
        );
}
