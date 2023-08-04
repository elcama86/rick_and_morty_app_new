import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';

part 'favorites_episodes_event.dart';
part 'favorites_episodes_state.dart';

class FavoritesEpisodesBloc
    extends Bloc<FavoritesEpisodesEvent, FavoritesEpisodesState> {
  final LocalStorageRepositoryImpl localStorageRepository;

  FavoritesEpisodesBloc({
    required this.localStorageRepository,
  }) : super(
          FavoritesEpisodesInitial(
            favoritesEpisodes: {},
            offset: 0,
            limit: 20,
            showIcon: false,
          ),
        ) {
    on<AddFavoriteEpisode>(_addFavoriteEpisode);
    on<RemoveFavoriteEpisode>(_removeFavoriteEpisode);
    on<SetFavorites>(_setFavorites);
    on<SetShowIcon>(_setShowIcon);
  }

  void _addFavoriteEpisode(
      AddFavoriteEpisode event, Emitter<FavoritesEpisodesState> emit) {
    emit(
      FavoritesEpisodesUpdate(
        favoritesEpisodes: {
          ...state.favoritesEpisodes,
          event.episodeId: event.episode,
        },
        offset: state.offset,
        limit: state.limit,
        showIcon: state.showIcon,
      ),
    );
  }

  void _removeFavoriteEpisode(
      RemoveFavoriteEpisode event, Emitter<FavoritesEpisodesState> emit) async {
    int favoritesLength = state.favoritesEpisodes.values.length;

    Episode? episode;

    if (favoritesLength == state.offset) {
      final int index = state.offset - 1;
      episode = await localStorageRepository.loadEpisodeByIndex(index);
    }

    state.favoritesEpisodes.remove(event.episodeId);

    emit(
      FavoritesEpisodesUpdate(
        favoritesEpisodes: episode != null
            ? {...state.favoritesEpisodes, episode.id: episode}
            : state.favoritesEpisodes,
        offset: state.offset,
        limit: state.limit,
        showIcon: state.showIcon,
      ),
    );
  }

  void _setFavorites(SetFavorites event, Emitter<FavoritesEpisodesState> emit) {
    emit(
      FavoritesEpisodesUpdate(
        favoritesEpisodes: {...state.favoritesEpisodes, ...event.newFavorites},
        offset: state.offset + state.limit,
        limit: state.limit,
        showIcon: state.showIcon,
      ),
    );
  }

  void _setShowIcon(SetShowIcon event, Emitter<FavoritesEpisodesState> emit) {
    emit(
      FavoritesEpisodesUpdate(
        favoritesEpisodes: state.favoritesEpisodes,
        offset: state.offset,
        limit: state.limit,
        showIcon: event.value,
      ),
    );
  }

  Future<List<Episode>> loadFavoritesEpisodes() async {
    final favoritesEpisodes = await localStorageRepository.loadEpisodes(
      offset: state.offset,
      limit: state.limit,
    );

    final Map<int, Episode> tempEpisodesMap = {};

    for (final episode in favoritesEpisodes) {
      tempEpisodesMap[episode.id] = episode;
    }

    add(SetFavorites(tempEpisodesMap));

    return favoritesEpisodes;
  }

  Future<bool> isFavorite(int episodeId) async {
    final isEpisodeFavorite =
        await localStorageRepository.isEpisodeFavorite(episodeId);

    add(SetShowIcon(isEpisodeFavorite));

    return isEpisodeFavorite;
  }

  Future<void> toggleFavorite(Episode episode) async {
    await localStorageRepository.toggleFavorite(episode);

    final isEpisodeFavorite = await isFavorite(episode.id);

    add(SetShowIcon(isEpisodeFavorite));

    int favoritesLength = state.favoritesEpisodes.values.length;

    final bool isEpisodeInFavorites =
        state.favoritesEpisodes[episode.id] != null;

    if (isEpisodeInFavorites) {
      add(RemoveFavoriteEpisode(episode.id));
    } else {
      if (favoritesLength == state.offset) return;
      add(AddFavoriteEpisode(episode.id, episode));
    }
  }
}
