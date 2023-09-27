part of 'favorites_episodes_bloc.dart';

class FavoritesEpisodesState extends Equatable {
  final Map<int, Episode> favoritesEpisodes;
  final int totalFavorites;
  final int offset;
  final int limit;
  final bool showIcon;
  final bool isFirstLoad;

  const FavoritesEpisodesState({
    this.favoritesEpisodes = const {},
    this.totalFavorites = 0,
    this.offset = 0,
    this.limit = 20,
    this.showIcon = false,
    this.isFirstLoad = true,
  });

  FavoritesEpisodesState copyWith({
    Map<int, Episode>? favoritesEpisodes,
    int? totalFavorites,
    int? offset,
    int? limit,
    bool? showIcon,
    bool? isFirstLoad,
  }) =>
      FavoritesEpisodesState(
        favoritesEpisodes: favoritesEpisodes ?? this.favoritesEpisodes,
        totalFavorites: totalFavorites ?? this.totalFavorites,
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
        showIcon: showIcon ?? this.showIcon,
        isFirstLoad: isFirstLoad ?? this.isFirstLoad,
      );

  @override
  List<Object> get props =>
      [favoritesEpisodes, totalFavorites, offset, limit, showIcon, isFirstLoad];
}
