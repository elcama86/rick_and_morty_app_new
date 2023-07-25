part of 'search_characters_bloc.dart';

class SearchCharactersState extends Equatable {
  final String query;
  final List<Character> results;
  final String errorMessage;

  const SearchCharactersState({
    this.query = '',
    this.results = const [],
    this.errorMessage = '',
  });

  SearchCharactersState copyWith({
    String? query,
    List<Character>? results,
    String? errorMessage,
  }) =>
      SearchCharactersState(
        query: query ?? this.query,
        results: results ?? this.results,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => [query, results, errorMessage];
}
