import '../domain.dart';

abstract class CharactersDatasource {
  Future<List<Character>> getCharactersByPage({int page = 1});
  Future<Character> getCharacterById(String id);
  Future<List<Character>> searchCharacters(String query);
}
