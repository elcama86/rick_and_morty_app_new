part of 'episodes_bloc.dart';

class EpisodesState extends Equatable {
  final bool isLoading;
  final bool isLastPage;
  final int page;
  final List<Episode> episodes;
  final String errorMessage;

  const EpisodesState({
    this.isLoading = false,
    this.isLastPage = false,
    this.page = 1,
    this.episodes = const [],
    this.errorMessage = '',
  });

  EpisodesState copyWith({
    bool? isLoading,
    bool? isLastPage,
    int? page,
    List<Episode>? episodes,
    String? errorMessage,
  }) =>
      EpisodesState(
        isLoading: isLoading ?? this.isLoading,
        isLastPage: isLastPage ?? this.isLastPage,
        page: page ?? this.page,
        episodes: episodes ?? this.episodes,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props =>
      [isLoading, isLastPage, page, episodes, errorMessage];
}
