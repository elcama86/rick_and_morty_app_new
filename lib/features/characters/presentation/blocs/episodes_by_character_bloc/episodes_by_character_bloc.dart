import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';

part 'episodes_by_character_event.dart';
part 'episodes_by_character_state.dart';

class EpisodesByCharacterBloc
    extends Bloc<EpisodesByCharacterEvent, EpisodesByCharacterState> {
  final Future<List<Episode>> Function(List<String> ids) getEpisodesByCharacter;

  EpisodesByCharacterBloc({
    required this.getEpisodesByCharacter,
  }) : super(const EpisodesByCharacterState()) {
    on<SetIsLoading>(_setIsLoading);
    on<SetNewCharacterEpisodes>(_setNewCharacterEpisodes);
    on<SetNextEpisodes>(_setNextEpisodes);
    on<SetHasError>(_setHasError);
  }

  void _setIsLoading(
      SetIsLoading event, Emitter<EpisodesByCharacterState> emit) {
    emit(
      state.copyWith(
        isLoading: event.isLoading,
      ),
    );
  }

  void _setNewCharacterEpisodes(
      SetNewCharacterEpisodes event, Emitter<EpisodesByCharacterState> emit) {
    emit(
      state.copyWith(
        episodesByCharacter: {
          ...state.episodesByCharacter,
          event.id: {
            "episodes": event.episodes,
            "totalEpisodes": event.totalEpisodes,
            "loaded": event.loaded,
          },
        },
      ),
    );
  }

  void _setNextEpisodes(
      SetNextEpisodes event, Emitter<EpisodesByCharacterState> emit) {
    emit(
      state.copyWith(
          episodesByCharacter: state.episodesByCharacter.map((key, value) {
        if (key == event.id) {
          return MapEntry(
            key,
            {
              "episodes": [...value['episodes'], ...event.episodes],
              "totalEpisodes": value['totalEpisodes'],
              "loaded": event.loaded,
            },
          );
        }
        return MapEntry(key, value);
      })),
    );
  }

  void _setHasError(SetHasError event, Emitter<EpisodesByCharacterState> emit) {
    emit(
      state.copyWith(
        hasError: event.hasError,
      ),
    );
  }

  Future<void> _verifyEpisodesByCharacter(
      String characterId, episodesIds) async {
    try {
      final loadedEpisodsCount =
          state.episodesByCharacter[characterId]!['loaded'];
      if (loadedEpisodsCount == episodesIds.length) {
        add(SetIsLoading(false));
        return;
      }

      late int endIndex;

      if (loadedEpisodsCount + 10 > episodesIds.length) {
        endIndex = episodesIds.length;
      } else {
        endIndex = loadedEpisodsCount + 10;
      }

      final episodes = await getEpisodesByCharacter(
          episodesIds.sublist(loadedEpisodsCount, endIndex));

      add(SetNextEpisodes(characterId, episodes, endIndex));
      add(SetIsLoading(false));
    } catch (e) {
      add(SetIsLoading(false));
      add(SetHasError(true));
    }
  }

  Future<void> loadEpisodes(
      String characterId, List<String> episodesIds) async {
    try {
      if (state.isLoading) return;

      add(SetIsLoading(true));
      add(SetHasError(false));

      if (state.episodesByCharacter[characterId] != null) {
        _verifyEpisodesByCharacter(characterId, episodesIds);
        return;
      }

      final episodes = episodesIds.length > 10
          ? await getEpisodesByCharacter(episodesIds.sublist(0, 10))
          : await getEpisodesByCharacter(episodesIds);

      add(SetNewCharacterEpisodes(
          characterId, episodes, episodesIds.length, episodes.length));
      add(SetIsLoading(false));
    } catch (e) {
      add(SetIsLoading(false));
      add(SetHasError(true));
    }
  }
}
