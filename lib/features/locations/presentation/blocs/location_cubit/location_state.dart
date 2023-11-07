part of 'location_cubit.dart';

class LocationState extends Equatable {
  final Map<String, Location> locationsMap;
  final String errorMessage;

  const LocationState({
    this.locationsMap = const {},
    this.errorMessage = '',
  });

  LocationState copyWith({
    Map<String, Location>? locationsMap,
    String? errorMessage,
  }) =>
      LocationState(
        locationsMap: locationsMap ?? this.locationsMap,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => [locationsMap, errorMessage];
}
