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
          ),
        ) {
    on<AddFavoriteEpisode>(_addFavoriteEpisode);
    on<RemoveFavoriteEpisode>(_removeFavoriteEpisode);
    on<SetFavorites>(_setFavorites);
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
      ),
    );
  }

  void _removeFavoriteEpisode(
      RemoveFavoriteEpisode event, Emitter<FavoritesEpisodesState> emit) {
    state.favoritesEpisodes.remove(event.episodeId);
    emit(
      FavoritesEpisodesUpdate(
        favoritesEpisodes: state.favoritesEpisodes,
        offset: state.offset,
        limit: state.limit,
      ),
    );
  }

  void _setFavorites(SetFavorites event, Emitter<FavoritesEpisodesState> emit) {
    emit(
      FavoritesEpisodesUpdate(
        favoritesEpisodes: {...state.favoritesEpisodes, ...event.newFavorites},
        offset: state.offset + state.limit,
        limit: state.limit,
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
    return localStorageRepository.isEpisodeFavorite(episodeId);
  }

  Future<void> toggleFavorite(Episode episode) async {
    await localStorageRepository.toggleFavorite(episode);

    final bool isEpisodeInFavorites =
        state.favoritesEpisodes[episode.id] != null;

    if (isEpisodeInFavorites) {
      add(RemoveFavoriteEpisode(episode.id));
    } else {
      add(AddFavoriteEpisode(episode.id, episode));
    }
  }
}
