part of 'characters_by_episode_bloc.dart';

class CharactersByEpisodeState extends Equatable {
  final bool isLoading;
  final Map<String, Map<String, dynamic>> charactersByEpisode;
  final bool hasError;

  const CharactersByEpisodeState({
    this.isLoading = false,
    this.charactersByEpisode = const {},
    this.hasError = false,
  });

  CharactersByEpisodeState copyWith({
    bool? isLoading,
    Map<String, Map<String, dynamic>>? charactersByEpisode,
    bool? hasError,
  }) =>
      CharactersByEpisodeState(
        isLoading: isLoading ?? this.isLoading,
        charactersByEpisode: charactersByEpisode ?? this.charactersByEpisode,
        hasError: hasError ?? this.hasError,
      );

  @override
  List<Object> get props => [isLoading, charactersByEpisode, hasError];
}
