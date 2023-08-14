import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

part 'episode_event.dart';
part 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final Future<Episode> Function(String) getEpisodeById;

  EpisodeBloc({
    required this.getEpisodeById,
  }) : super(const EpisodeState()) {
    on<SetEpisode>(_setEpisode);
    on<SetEpisodeErrorMessage>(_setEpisodeErrorMessage);
  }

  void _setEpisode(SetEpisode event, Emitter<EpisodeState> emit) {
    emit(
      state.copyWith(
        episodesMap: {...state.episodesMap, event.id: event.episode},
      ),
    );
  }

  void _setEpisodeErrorMessage(
      SetEpisodeErrorMessage event, Emitter<EpisodeState> emit) {
    emit(
      state.copyWith(
        errorMessage: event.message,
      ),
    );
  }

  Future<void> getEpisode(String id) async {
    try {
      if (state.episodesMap[id] != null) return;
      add(SetEpisodeErrorMessage(''));

      await Future.delayed(const Duration(milliseconds: 500));

      final episode = await getEpisodeById(id);

      add(SetEpisode(id, episode));
    } on EpisodeNotFound {
      add(SetEpisodeErrorMessage('Episodio con id: $id no existe'));
    } on CustomError catch (e) {
      add(SetEpisodeErrorMessage(e.message));
    } catch (e) {
      add(SetEpisodeErrorMessage('Ha ocurrido un error inesperado'));
    }
  }
}
