import 'package:rick_and_morty_app/features/episodes/episodes.dart';

abstract class EpisodesDatasource {
  Future<List<Episode>> getEpisodesByPage({int page = 1});
  Future<Episode> getEpisodeById(String id);
  Future<List<Episode>> searchEpisodes(String query);
  Future<List<Episode>> getEpisodesByList(List<String> ids);
}
