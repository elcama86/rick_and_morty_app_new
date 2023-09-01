import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final Future<List<Episode>> Function({int page}) getEpisodesByPage;

  EpisodesBloc({
    required this.getEpisodesByPage,
  }) : super(const EpisodesState()) {
    on<SetEpisodes>(_setEpisodes);
    on<SetLoadingEpisodes>(_setLoadingEpisodes);
    on<SetIsLastPage>(_setIsLastPage);
    on<ChangePage>(_changePage);
    on<SetErrorMessage>(_setErrorMessage);
  }

  void _setEpisodes(SetEpisodes event, Emitter<EpisodesState> emit) {
    emit(
      state.copyWith(
        episodes: [...state.episodes, ...event.episodes],
      ),
    );
  }

  void _setLoadingEpisodes(
      SetLoadingEpisodes event, Emitter<EpisodesState> emit) {
    emit(
      state.copyWith(
        isLoading: event.value,
      ),
    );
  }

  void _setIsLastPage(SetIsLastPage event, Emitter<EpisodesState> emit) {
    emit(
      state.copyWith(
        isLastPage: event.value,
      ),
    );
  }

  void _changePage(ChangePage event, Emitter<EpisodesState> emit) {
    emit(
      state.copyWith(
        page: event.page,
      ),
    );
  }

  void _setErrorMessage(SetErrorMessage event, Emitter<EpisodesState> emit) {
    emit(
      state.copyWith(
        errorMessage: event.message,
      ),
    );
  }

  Future<void> loadNextPage() async {
    try {
      if (state.isLoading || state.isLastPage) return;
      add(SetLoadingEpisodes(true));
      add(SetErrorMessage(''));

      await Future.delayed(const Duration(milliseconds: 500));

      final episodes = await getEpisodesByPage(page: state.page);

      add(SetLoadingEpisodes(false));
      add(SetIsLastPage(false));
      add(ChangePage(state.page + 1));
      add(SetEpisodes(episodes));
    } on EpisodeNotFound {
      add(SetLoadingEpisodes(false));
      add(SetIsLastPage(true));
    } on CustomError catch (e) {
      add(SetLoadingEpisodes(false));
      add(SetErrorMessage(e.message));
    } catch (e) {
      add(SetLoadingEpisodes(false));
      add(SetErrorMessage('unexpected_error'));
    }
  }
}
