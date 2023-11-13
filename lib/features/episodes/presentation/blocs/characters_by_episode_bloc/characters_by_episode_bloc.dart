import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

part 'characters_by_episode_event.dart';
part 'characters_by_episode_state.dart';

class CharactersByEpisodeBloc
    extends Bloc<CharactersByEpisodeEvent, CharactersByEpisodeState> {
  final Future<List<Character>> Function(List<String> ids)
      getCharactersByEpisode;

  CharactersByEpisodeBloc({
    required this.getCharactersByEpisode,
  }) : super(const CharactersByEpisodeState()) {
    on<SetIsLoading>(_setIsLoading);
    on<SetNewEpisodeCharacters>(_setNewEpisodeCharacters);
    on<SetNextCharacters>(_setNextCharacters);
    on<SetHasError>(_setHasError);
  }

  void _setIsLoading(
      SetIsLoading event, Emitter<CharactersByEpisodeState> emit) {
    emit(
      state.copyWith(
        isLoading: event.value,
      ),
    );
  }

  void _setNewEpisodeCharacters(
      SetNewEpisodeCharacters event, Emitter<CharactersByEpisodeState> emit) {
    emit(
      state.copyWith(
        charactersByEpisode: {
          ...state.charactersByEpisode,
          event.episodeId: {
            "characters": event.characters,
            "totalCharacters": event.totalCharacters,
            "loaded": event.loaded,
          },
        },
      ),
    );
  }

  void _setNextCharacters(
      SetNextCharacters event, Emitter<CharactersByEpisodeState> emit) {
    emit(
      state.copyWith(
        charactersByEpisode: state.charactersByEpisode.map((key, value) {
          if (key == event.episodeId) {
            return MapEntry(
              key,
              {
                "characters": [...value['characters'], ...event.nextCharacters],
                "totalCharacters": value['totalCharacters'],
                "loaded": event.loaded,
              },
            );
          }
          return MapEntry(key, value);
        }),
      ),
    );
  }

  void _setHasError(SetHasError event, Emitter<CharactersByEpisodeState> emit) {
    emit(
      state.copyWith(
        hasError: event.value,
      ),
    );
  }

  Future<void> _verifyCharactersByEpisode(
      String episodeId, List<String> charactersIds) async {
    try {
      final loadedCharactersCount =
          state.charactersByEpisode[episodeId]!['loaded'];
      if (loadedCharactersCount == charactersIds.length) {
        add(SetIsLoading(false));
        return;
      }

      int endIndex =
          SharedUtils.getEndIndex(loadedCharactersCount, charactersIds.length);

      final characters = await getCharactersByEpisode(
          charactersIds.sublist(loadedCharactersCount, endIndex));

      add(SetNextCharacters(episodeId, characters, endIndex));
      add(SetIsLoading(false));
    } catch (e) {
      add(SetIsLoading(false));
      add(SetHasError(true));
    }
  }

  Future<void> loadCharacters(
      String episodeId, List<String> charactersIds) async {
    try {
      if (state.isLoading && state.charactersByEpisode[episodeId] != null) {
        return;
      }

      add(SetIsLoading(true));
      add(SetHasError(false));

      if (state.charactersByEpisode[episodeId] != null) {
        _verifyCharactersByEpisode(episodeId, charactersIds);
        return;
      }

      final characters = charactersIds.length > 10
          ? await getCharactersByEpisode(charactersIds.sublist(0, 10))
          : await getCharactersByEpisode(charactersIds);

      add(SetNewEpisodeCharacters(
          episodeId, characters, charactersIds.length, characters.length));
      add(SetIsLoading(false));
    } catch (e) {
      add(SetIsLoading(false));
      add(SetHasError(true));
    }
  }
}
