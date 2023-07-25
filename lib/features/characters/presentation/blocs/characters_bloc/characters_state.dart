part of 'characters_bloc.dart';

class CharactersState extends Equatable {
  final bool isLoading;
  final bool isLastPage;
  final int page;
  final List<Character> characters;
  final String errorMessage;

  const CharactersState({
    this.isLoading = false,
    this.isLastPage = false,
    this.page = 1,
    this.characters = const [],
    this.errorMessage = '',
  });

  CharactersState copyWith({
    bool? isLoading,
    bool? isLastPage,
    int? page,
    List<Character>? characters,
    String? errorMessage,
  }) =>
      CharactersState(
        isLoading: isLoading ?? this.isLoading,
        isLastPage: isLastPage ?? this.isLastPage,
        page: page ?? this.page,
        characters: characters ?? this.characters,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props =>
      [isLoading, isLastPage, page, characters, errorMessage];
}
