import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/config/constants/environment.dart';
import 'package:rick_and_morty_app/features/locations/domain/domain.dart';
import 'package:rick_and_morty_app/features/locations/infrastructure/infrastructure.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class LocationsDatasourceImpl extends LocationsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    ),
  );

  String currentQuery = '';

  List<Location> _jsonToLocations(Map<String, dynamic> json) {
    final locationResponse = LocationsResponse.fromJson(json);

    final List<Location> locations = locationResponse.results
        .map((result) => LocationMappers.resultToEntity(result))
        .toList();

    return locations;
  }

  @override
  Future<Location> getLocationById(String id) async {
    try {
      final response = await dio.get(
        '/location/$id',
      );

      final locationDetails = LocationDetails.fromJson(response.data);

      final location = LocationMappers.locationDetailsToEntity(locationDetails);

      return location;
    } on DioException catch (e) {
      SharedUtils.checkDioException(e, 'location');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Location>> getLocationsByPage({int page = 1}) async {
    try {
      final response = await dio.get(
        '/location',
        queryParameters: {
          'page': page,
        },
      );

      return _jsonToLocations(response.data);
    } on DioException catch (e) {
      SharedUtils.checkDioException(e, 'location');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Location>> searchLocations(String query) async {
    try {
      currentQuery = query;

      if (query.isEmpty) return [];

      final response = await dio.get(
        '/location',
        queryParameters: {
          'name': query,
        },
      );

      if (currentQuery != query) return [];

      return _jsonToLocations(response.data);
    } on DioException catch (e) {
      SharedUtils.checkDioException(e, 'location');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
