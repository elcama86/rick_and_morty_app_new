import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/config/constants/environment.dart';
import 'package:rick_and_morty_app/features/episodes/episodes.dart';
import 'package:rick_and_morty_app/features/shared/shared.dart';

class EpisodeDatasourceImpl extends EpisodesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    ),
  );

  void _checkDioException(DioException e) {
    if (e.response?.statusCode == 404) {
      throw EpisodeNotFound();
    }
    if (e.type == DioExceptionType.connectionTimeout) {
      throw CustomError(
          "Problemas de conexión, por favor revise su conexión a internet");
    }
    if (e.type == DioExceptionType.unknown &&
        e.error.runtimeType == SocketException) {
      throw CustomError("Sin conexión a internet");
    }
  }

  @override
  Future<Episode> getEpisodeById(String id) async {
    try {
      final response = await dio.get(
        '/episode/$id',
      );

      final episodeDetails = EpisodeDetails.fromJson(response.data);

      final episode = EpisodeMapper.episodeDetailsToEntity(episodeDetails);

      return episode;
    } on DioException catch (e) {
      _checkDioException(e);
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  List<Episode> _jsonToEpisodes(Map<String, dynamic> json) {
    final episodesResponse = EpisodesResponse.fromJson(json);

    final episodes = episodesResponse.results
        .map((result) => EpisodeMapper.resultToEntity(result))
        .toList();

    return episodes;
  }

  @override
  Future<List<Episode>> getEpisodesByPage({int page = 1}) async {
    try {
      final response = await dio.get(
        '/episode',
        queryParameters: {
          'page': page,
        },
      );

      return _jsonToEpisodes(response.data);
    } on DioException catch (e) {
      _checkDioException(e);
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Episode>> searchEpisodes(String query) async {
    try {
      if (query.isEmpty) return [];

      final response = await dio.get(
        '/episode',
        queryParameters: {
          'name': query,
        },
      );

      return _jsonToEpisodes(response.data);
    } on DioException catch (e) {
      _checkDioException(e);
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
