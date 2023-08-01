import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty_app/features/episodes/domain/domain.dart';

class LocalStorageDatasourceImpl extends LocalStorageDatasource {
  Isar? isar;

  LocalStorageDatasourceImpl() {
    openIsar();
  }

  void openIsar() async {
    final dir = await getApplicationDocumentsDirectory();

    isar ??= await Isar.open(
      [EpisodeSchema],
      directory: dir.path,
    );
  }

  @override
  Future<bool> isEpisodeFavorite(int episodeId) async {
    final Episode? favoriteEpisode =
        await isar!.episodes.filter().idEqualTo(episodeId).findFirst();
    return favoriteEpisode != null;
  }

  @override
  Future<List<Episode>> loadEpisodes({int limit = 10, int offset = 0}) {
    return isar!.episodes.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorite(Episode episode) async {
    final Episode? favoriteEpisode =
        await isar!.episodes.filter().idEqualTo(episode.id).findFirst();

    if (favoriteEpisode != null) {
      await isar!.writeTxn(() async {
        await isar!.episodes.delete(favoriteEpisode.isarId);
        return;
      });
    }

    await isar!.writeTxn(() async {
      await isar!.episodes.put(episode);
    });
  }
}
