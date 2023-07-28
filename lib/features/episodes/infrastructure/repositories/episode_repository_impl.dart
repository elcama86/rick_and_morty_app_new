import 'package:rick_and_morty_app/features/episodes/episodes.dart';

class EpisodeRepositoryImpl extends EpisodesRepository {
  final EpisodesDatasource datasource;

  EpisodeRepositoryImpl(this.datasource);

  @override
  Future<Episode> getEpisodeById(String id) {
    return datasource.getEpisodeById(id);
  }

  @override
  Future<List<Episode>> getEpisodesByPage({int page = 1}) {
    return datasource.getEpisodesByPage(page: page);
  }

  @override
  Future<List<Episode>> searchEpisodes(String query) {
    return datasource.searchEpisodes(query);
  }

  @override
  Future<List<Episode>> getEpisodesByList(List<String> ids) {
    return datasource.getEpisodesByList(ids);
  }
}
