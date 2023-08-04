import 'package:rick_and_morty_app/features/episodes/domain/domain.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  Future<bool> isEpisodeFavorite(int episodeId) {
    return datasource.isEpisodeFavorite(episodeId);
  }

  @override
  Future<List<Episode>> loadEpisodes({int limit = 10, int offset = 0}) {
    return datasource.loadEpisodes(
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<void> toggleFavorite(Episode episode) {
    return datasource.toggleFavorite(episode);
  }

  @override
  Future<Episode?> loadEpisodeByIndex(int index) {
    return datasource.loadEpisodeByIndex(index);
  }
}
