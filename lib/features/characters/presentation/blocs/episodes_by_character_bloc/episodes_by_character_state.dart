part of 'episodes_by_character_bloc.dart';

class EpisodesByCharacterState extends Equatable {
  final bool isLoading;
  final Map<String, Map<String, dynamic>> episodesByCharacter;
  final bool hasError;

  const EpisodesByCharacterState({
    this.isLoading = false,
    this.episodesByCharacter = const {},
    this.hasError = false,
  });

  EpisodesByCharacterState copyWith({
    bool? isLoading,
    Map<String, Map<String, dynamic>>? episodesByCharacter,
    bool? hasError,
  }) =>
      EpisodesByCharacterState(
        isLoading: isLoading ?? this.isLoading,
        episodesByCharacter: episodesByCharacter ?? this.episodesByCharacter,
        hasError: hasError ?? this.hasError,
      );

  @override
  List<Object> get props => [isLoading, episodesByCharacter, hasError];
}
