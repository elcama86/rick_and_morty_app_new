import 'package:rick_and_morty_app/features/characters/domain/domain.dart';
import 'package:rick_and_morty_app/features/characters/infrastructure/infrastructure.dart';

class CharacterMapper {
  static Character resultToEntity(Result result) => Character(
        id: result.id,
        name: result.name,
        status: result.status,
        species: result.species,
        type: result.type,
        gender: result.gender,
        origin: result.origin.name,
        location: result.location.name,
        image: result.image,
        created: result.created,
      );

  static Character characterDetailsToEntity(
          CharacterDetails characterDetails) =>
      Character(
        id: characterDetails.id,
        name: characterDetails.name,
        status: characterDetails.status,
        species: characterDetails.species,
        type: characterDetails.type,
        gender: characterDetails.gender,
        origin: characterDetails.origin.name,
        location: characterDetails.location.name,
        image: characterDetails.image,
        created: characterDetails.created,
      );
}
