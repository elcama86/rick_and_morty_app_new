import 'package:rick_and_morty_app/features/episodes/episodes.dart';

abstract class EpisodesRepository {
  Future<List<Episode>> getEpisodesByPage({int page = 1});
  Future<Episode> getEpisodeById(String id);
}