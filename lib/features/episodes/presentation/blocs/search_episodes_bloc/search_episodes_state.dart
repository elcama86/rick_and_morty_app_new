part of 'search_episodes_bloc.dart';

class SearchEpisodesState extends Equatable {
  final String query;
  final List<Episode> results;
  final String errorMessage;
  final bool isLoading;

  const SearchEpisodesState({
    this.query = '',
    this.results = const [],
    this.errorMessage = '',
    this.isLoading = false,
  });

  SearchEpisodesState copyWith({
    String? query,
    List<Episode>? results,
    String? errorMessage,
    bool? isLoading,
  }) =>
      SearchEpisodesState(
        query: query ?? this.query,
        results: results ?? this.results,
        errorMessage: errorMessage ?? this.errorMessage,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object> get props => [query, results, errorMessage, isLoading];
}
