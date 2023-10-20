import '../../domain/entities/location.dart';
import '../models/models.dart';

class LocationMappers {
  static Location resultToEntity(Result result) => Location(
        id: result.id,
        name: result.name,
        type: result.type,
        dimension: result.dimension,
        residents: List<String>.from(result.residents.map((r) => r)),
        created: result.created,
      );

  static Location locationDetailsToEntity(LocationDetails locationDetails) =>
      Location(
        id: locationDetails.id,
        name: locationDetails.name,
        type: locationDetails.type,
        dimension: locationDetails.dimension,
        residents: List<String>.from(locationDetails.residents.map((r) => r)),
        created: locationDetails.created,
      );
}
