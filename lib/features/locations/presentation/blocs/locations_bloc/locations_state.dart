part of 'locations_bloc.dart';

class LocationsState extends Equatable {
  final bool isLoading;
  final bool isLastPage;
  final int page;
  final List<Location> locations;
  final String errorMessage;

  const LocationsState({
    this.isLoading = false,
    this.isLastPage = false,
    this.page = 1,
    this.locations = const [],
    this.errorMessage = '',
  });

  LocationsState copyWith({
    bool? isLoading,
    bool? isLastPage,
    int? page,
    List<Location>? locations,
    String? errorMessage,
  }) =>
      LocationsState(
        isLoading: isLoading ?? this.isLoading,
        isLastPage: isLastPage ?? this.isLastPage,
        page: page ?? this.page,
        locations: locations ?? this.locations,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props =>
      [isLoading, isLastPage, page, locations, errorMessage];
}
