import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rick_and_morty_app/features/episodes/domain/domain.dart';

class LocalStorageDatasourceImpl extends LocalStorageDatasource {
  late Future<Isar> isar;

  LocalStorageDatasourceImpl() {
    isar = openIsar();
  }

  Future<Isar> openIsar() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [EpisodeSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isEpisodeFavorite(int episodeId) async {
    final db = await isar;

    final Episode? favoriteEpisode =
        await db.episodes.filter().idEqualTo(episodeId).findFirst();

    return favoriteEpisode != null;
  }

  @override
  Future<List<Episode>> loadEpisodes({int limit = 20, int offset = 0}) async {
    final db = await isar;

    return db.episodes.where().offset(offset).limit(limit).findAll();
  }

  @override
  Future<void> toggleFavorite(Episode episode) async {
    final db = await isar;

    final Episode? favoriteEpisode =
        await db.episodes.filter().idEqualTo(episode.id).findFirst();

    if (favoriteEpisode != null) {
      db.writeTxnSync(() => db.episodes.deleteSync(favoriteEpisode.isarId));
      return;
    }

    db.writeTxnSync(() => db.episodes.putSync(episode));
  }
}
