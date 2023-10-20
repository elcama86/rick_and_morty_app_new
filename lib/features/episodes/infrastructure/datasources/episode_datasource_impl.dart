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

  String currentQuery = '';

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
      SharedUtils.checkDioException(e, 'episode');
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
      SharedUtils.checkDioException(e, 'episode');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Episode>> searchEpisodes(String query) async {
    try {
      currentQuery = query;

      if (query.isEmpty) return [];

      final response = await dio.get(
        '/episode',
        queryParameters: {
          'name': query,
        },
      );

      if (currentQuery != query) return [];

      return _jsonToEpisodes(response.data);
    } on DioException catch (e) {
      SharedUtils.checkDioException(e, 'episode');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<Episode>> getEpisodesByList(List<String> ids) async {
    try {
      final List<Future<Episode>> getEpisodesJob =
          ids.map(getEpisodeById).toList();

      final episodes = await Future.wait(getEpisodesJob);

      return episodes;
    } on DioException catch (e) {
      SharedUtils.checkDioException(e, 'episode');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
