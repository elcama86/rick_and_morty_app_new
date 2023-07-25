import 'package:rick_and_morty_app/features/characters/domain/domain.dart';

class CharactersRepositoryImpl extends CharactersRepository {
  final CharactersDatasource datasource;

  CharactersRepositoryImpl(this.datasource);

  @override
  Future<Character> getCharacterById(String id) {
    return datasource.getCharacterById(id);
  }

  @override
  Future<List<Character>> getCharactersByPage({int page = 1}) {
    return datasource.getCharactersByPage(page: page);
  }

  @override
  Future<List<Character>> searchCharacters(String query) {
    return datasource.searchCharacters(query);
  }
}
