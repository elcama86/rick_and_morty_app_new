import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/config/constants/environment.dart';
import 'package:rick_and_morty_app/features/characters/domain/domain.dart';
import 'package:rick_and_morty_app/features/characters/infrastructure/infrastructure.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class CharactersDatasourceImpl extends CharactersDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    ),
  );

  String currentQuery = '';

  List<Character> _jsonToCharacters(Map<String, dynamic> json) {
    final charactersResponse = CharactersResponse.fromJson(json);

    final List<Character> characters = charactersResponse.results
        .map((result) => CharacterMapper.resultToEntity(result))
        .toList();

    return characters;
  }

  @override
  Future<Character> getCharacterById(String id) async {
    try {
      final response = await dio.get(
        '/character/$id',
      );

      final characterDetails = CharacterDetails.fromJson(response.data);

      final character =
          CharacterMapper.characterDetailsToEntity(characterDetails);

      return character;
    } on DioException catch (e) {
      SharedUtils.checkDioException(e, 'character');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Character>> getCharactersByPage({int page = 1}) async {
    try {
      final response = await dio.get(
        '/character',
        queryParameters: {
          'page': page,
        },
      );

      return _jsonToCharacters(response.data);
    } on DioException catch (e) {
      SharedUtils.checkDioException(e, 'character');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Character>> searchCharacters(String query) async {
    try {
      currentQuery = query;

      if (query.isEmpty) return [];

      final response = await dio.get(
        '/character',
        queryParameters: {
          'name': query,
        },
      );

      if (currentQuery != query) return [];

      return _jsonToCharacters(response.data);
    } on DioException catch (e) {
      SharedUtils.checkDioException(e, 'character');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Character>> getCharactersByList(List<String> ids) async {
    try {
      final List<Future<Character>> getCharactersJob =
          ids.map(getCharacterById).toList();

      final characters = await Future.wait(getCharactersJob);

      return characters;
    } on CustomError catch (_) {
      rethrow;
    } catch (e) {
      throw Exception();
    }
  }
}
