part of 'residents_by_location_bloc.dart';

class ResidentsByLocationState extends Equatable {
  final bool isLoading;
  final Map<String, dynamic> residentsByLocation;
  final bool hasError;

  const ResidentsByLocationState({
    this.isLoading = false,
    this.residentsByLocation = const {},
    this.hasError = false,
  });

  ResidentsByLocationState copyWith({
    bool? isLoading,
    Map<String, dynamic>? residentsByLocation,
    bool? hasError,
  }) =>
      ResidentsByLocationState(
        isLoading: isLoading ?? this.isLoading,
        residentsByLocation: residentsByLocation ?? this.residentsByLocation,
        hasError: hasError ?? this.hasError,
      );

  @override
  List<Object> get props => [isLoading, residentsByLocation, hasError];
}
