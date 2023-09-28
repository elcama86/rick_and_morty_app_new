import '../entities/episode.dart';

abstract class LocalStorageDatasource {
  Future<int> toggleFavorite(Episode episode);
  Future<bool> isEpisodeFavorite(int episodeId);
  Future<List<Episode>> loadEpisodes({int limit = 10, int offset = 0});
  Future<Episode?> loadEpisodeByIndex(int index);
  Future<void> clearDb();
  Future<int> totalFavorites();
}
