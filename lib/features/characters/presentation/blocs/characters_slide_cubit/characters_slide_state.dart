part of 'characters_slide_cubit.dart';

class CharactersSlideState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final bool isRetrying;
  final List<Character> characters;

  const CharactersSlideState({
    this.isLoading = true,
    this.errorMessage = '',
    this.isRetrying = false,
    this.characters = const [],
  });

  CharactersSlideState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isRetrying,
    List<Character>? characters,
  }) =>
      CharactersSlideState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        isRetrying: isRetrying ?? this.isRetrying,
        characters: characters ?? this.characters,
      );

  @override
  List<Object> get props => [isLoading, errorMessage, isRetrying, characters];
}
