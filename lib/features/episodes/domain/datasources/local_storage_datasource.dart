import '../entities/episode.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavorite(Episode episode);
  Future<bool> isEpisodeFavorite(int episodeId);
  Future<List<Episode>> loadEpisodes({int limit = 10, int offset = 0});
}
