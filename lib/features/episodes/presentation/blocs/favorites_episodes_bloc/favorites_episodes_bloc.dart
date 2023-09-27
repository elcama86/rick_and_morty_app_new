import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';

part 'favorites_episodes_event.dart';
part 'favorites_episodes_state.dart';

class FavoritesEpisodesBloc
    extends Bloc<FavoritesEpisodesEvent, FavoritesEpisodesState> {
  final LocalStorageRepository localStorageRepository;

  FavoritesEpisodesBloc({
    required this.localStorageRepository,
  }) : super(
          const FavoritesEpisodesState(),
        ) {
    on<AddFavoriteEpisode>(_addFavoriteEpisode);
    on<RemoveFavoriteEpisode>(_removeFavoriteEpisode);
    on<SetFavorites>(_setFavorites);
    on<SetShowIcon>(_setShowIcon);
    on<ChangeIsFirstLoad>(_changeIsFirstLoad);
    on<SetTotalFavorites>(_setTotalFavorites);
  }

  void _addFavoriteEpisode(
      AddFavoriteEpisode event, Emitter<FavoritesEpisodesState> emit) {
    emit(
      state.copyWith(
        favoritesEpisodes: {
          ...state.favoritesEpisodes,
          event.episodeId: event.episode,
        },
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
      state.copyWith(
        favoritesEpisodes: episode != null
            ? {...state.favoritesEpisodes, episode.id: episode}
            : state.favoritesEpisodes,
      ),
    );
  }

  void _setFavorites(SetFavorites event, Emitter<FavoritesEpisodesState> emit) {
    emit(
      state.copyWith(
        favoritesEpisodes: {...state.favoritesEpisodes, ...event.newFavorites},
        offset: state.offset + state.limit,
      ),
    );
  }

  void _setShowIcon(SetShowIcon event, Emitter<FavoritesEpisodesState> emit) {
    emit(
      state.copyWith(
        showIcon: event.value,
      ),
    );
  }

  void _changeIsFirstLoad(
      ChangeIsFirstLoad event, Emitter<FavoritesEpisodesState> emit) {
    if (state.isFirstLoad == false) return;
    emit(
      state.copyWith(
        isFirstLoad: event.value,
      ),
    );
  }

  void _setTotalFavorites(
      SetTotalFavorites event, Emitter<FavoritesEpisodesState> emit) {
    emit(
      state.copyWith(
        totalFavorites: event.total,
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
    add(ChangeIsFirstLoad(!state.isFirstLoad));

    return favoritesEpisodes;
  }

  Future<bool> isFavorite(int episodeId) async {
    final isEpisodeFavorite =
        await localStorageRepository.isEpisodeFavorite(episodeId);

    add(SetShowIcon(isEpisodeFavorite));

    return isEpisodeFavorite;
  }

  Future<void> toggleFavorite(Episode episode) async {
    int totalFavorites = await localStorageRepository.toggleFavorite(episode);

    add(SetTotalFavorites(totalFavorites));

    await isFavorite(episode.id);

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
