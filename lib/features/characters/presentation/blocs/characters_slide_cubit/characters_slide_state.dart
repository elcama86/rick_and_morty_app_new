part of 'characters_slide_cubit.dart';

class CharactersSlideState extends Equatable {
  final bool isLoading;
  final bool hasError;
  final List<Character> characters;

  const CharactersSlideState({
    this.isLoading = true,
    this.hasError = false,
    this.characters = const [],
  });

  CharactersSlideState copyWith({
    bool? isLoading,
    bool? hasError,
    List<Character>? characters,
  }) =>
      CharactersSlideState(
        isLoading: isLoading ?? this.isLoading,
        hasError: hasError ?? this.hasError,
        characters: characters ?? this.characters,
      );

  @override
  List<Object> get props => [isLoading, hasError, characters];
}
