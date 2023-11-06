part of 'search_locations_bloc.dart';

class SearchLocationsState extends Equatable {
  final String query;
  final List<Location> results;
  final String errorMessage;
  final bool isLoading;

  const SearchLocationsState({
    this.query = '',
    this.results = const [],
    this.errorMessage = '',
    this.isLoading = false,
  });

  SearchLocationsState copyWith({
    String? query,
    List<Location>? results,
    String? errorMessage,
    bool? isLoading,
  }) =>
      SearchLocationsState(
        query: query ?? this.query,
        results: results ?? this.results,
        errorMessage: errorMessage ?? this.errorMessage,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object> get props => [query, results, errorMessage, isLoading];
}
