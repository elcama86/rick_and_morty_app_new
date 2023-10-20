class EpisodeNotFound implements Exception {}

class CharacterNotFound implements Exception {}

class LocationNotFound implements Exception {}

class CustomError implements Exception {
  final String message;

  CustomError(this.message);
}