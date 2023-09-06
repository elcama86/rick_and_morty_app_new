part of 'search_characters_bloc.dart';

class SearchCharactersState extends Equatable {
  final String query;
  final List<Character> results;
  final String errorMessage;
  final bool isLoading;

  const SearchCharactersState({
    this.query = '',
    this.results = const [],
    this.errorMessage = '',
    this.isLoading = false,
  });

  SearchCharactersState copyWith({
    String? query,
    List<Character>? results,
    String? errorMessage,
    bool? isLoading,
  }) =>
      SearchCharactersState(
        query: query ?? this.query,
        results: results ?? this.results,
        errorMessage: errorMessage ?? this.errorMessage,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object> get props => [query, results, errorMessage, isLoading];
}
