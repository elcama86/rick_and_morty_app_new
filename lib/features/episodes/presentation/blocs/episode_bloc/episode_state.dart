part of 'episode_bloc.dart';

class EpisodeState extends Equatable {
  final Map<String, Episode> episodesMap;
  final String errorMessage;

  const EpisodeState({
    this.episodesMap = const {},
    this.errorMessage = '',
  });

  EpisodeState copyWith({
    Map<String, Episode>? episodesMap,
    String? errorMessage,
  }) =>
      EpisodeState(
        episodesMap: episodesMap ?? this.episodesMap,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => [episodesMap, errorMessage];
}
