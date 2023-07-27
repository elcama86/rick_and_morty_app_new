part of 'search_episodes_bloc.dart';

class SearchEpisodesState extends Equatable {
  final String query;
  final List<Episode> results;
  final String errorMessage;

  const SearchEpisodesState({
    this.query = '',
    this.results = const [],
    this.errorMessage = '',
  });

  SearchEpisodesState copyWith({
    String? query,
    List<Episode>? results,
    String? errorMessage,
  }) =>
      SearchEpisodesState(
        query: query ?? this.query,
        results: results ?? this.results,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => [query, results, errorMessage];
}
