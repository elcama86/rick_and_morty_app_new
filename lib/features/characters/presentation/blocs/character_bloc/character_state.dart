part of 'character_bloc.dart';

class CharacterState extends Equatable {
  final Map<String, Character> charactersMap;
  final String errorMessage;

  const CharacterState({
    this.charactersMap = const {},
    this.errorMessage = '',
  });

  CharacterState copyWith({
    Map<String, Character>? charactersMap,
    String? errorMessage,
  }) =>
      CharacterState(
        charactersMap: charactersMap ?? this.charactersMap,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => [charactersMap, errorMessage];
}
