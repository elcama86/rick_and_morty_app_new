part of 'characters_slide_cubit.dart';

class CharactersSlideState extends Equatable {
  final bool isLoading;
  final bool hasError;
  final bool isRetrying;
  final List<Character> characters;

  const CharactersSlideState({
    this.isLoading = true,
    this.hasError = false,
    this.isRetrying = false,
    this.characters = const [],
  });

  CharactersSlideState copyWith({
    bool? isLoading,
    bool? hasError,
    bool? isRetrying,
    List<Character>? characters,
  }) =>
      CharactersSlideState(
        isLoading: isLoading ?? this.isLoading,
        hasError: hasError ?? this.hasError,
        isRetrying: isRetrying ?? this.isRetrying,
        characters: characters ?? this.characters,
      );

  @override
  List<Object> get props => [isLoading, hasError, isRetrying, characters];
}
