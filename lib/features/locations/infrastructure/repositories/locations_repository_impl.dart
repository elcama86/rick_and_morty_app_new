import 'package:rick_and_morty_app/features/locations/domain/domain.dart';

class LocationsRepositoryImpl extends LocationsRepository {
  final LocationsDatasource datasource;

  LocationsRepositoryImpl(this.datasource);

  @override
  Future<Location> getLocationById(String id) {
    return datasource.getLocationById(id);
  }

  @override
  Future<List<Location>> getLocationsByPage({int page = 1}) {
    return datasource.getLocationsByPage(page: page);
  }

  @override
  Future<List<Location>> searchLocations(String query) {
    return datasource.searchLocations(query);
  }
}
