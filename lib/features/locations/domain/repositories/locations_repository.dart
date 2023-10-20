import '../domain.dart';

abstract class LocationsRepository {
  Future<List<Location>> getLocationsByPage({int page = 1});
  Future<Location> getLocationById(String id);
  Future<List<Location>> searchLocations(String query);
}
