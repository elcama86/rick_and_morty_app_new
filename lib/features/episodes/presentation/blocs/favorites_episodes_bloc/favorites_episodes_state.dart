part of 'favorites_episodes_bloc.dart';

class FavoritesEpisodesState extends Equatable {
  final Map<int, Episode> favoritesEpisodes;

  final int offset;
  final int limit;
  final bool showIcon;
  final bool isFirstLoad;

  const FavoritesEpisodesState({
    this.favoritesEpisodes = const {},
    this.offset = 0,
    this.limit = 20,
    this.showIcon = false,
    this.isFirstLoad = true,
  });

  FavoritesEpisodesState copyWith({
    Map<int, Episode>? favoritesEpisodes,
    int? offset,
    int? limit,
    bool? showIcon,
    bool? isFirstLoad,
  }) =>
      FavoritesEpisodesState(
        favoritesEpisodes: favoritesEpisodes ?? this.favoritesEpisodes,
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
        showIcon: showIcon ?? this.showIcon,
        isFirstLoad: isFirstLoad ?? this.isFirstLoad,
      );

  @override
  List<Object> get props =>
      [favoritesEpisodes, offset, limit, showIcon, isFirstLoad];
}
