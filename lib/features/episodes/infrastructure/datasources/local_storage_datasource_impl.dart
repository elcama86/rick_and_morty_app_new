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
  Future<int> toggleFavorite(Episode episode) async {
    final db = await isar;

    final Episode? favoriteEpisode =
        await db.episodes.filter().idEqualTo(episode.id).findFirst();

    if (favoriteEpisode != null) {
      db.writeTxnSync(() => db.episodes.deleteSync(favoriteEpisode.isarId));
      return db.episodes.where().findAllSync().length;
    }

    db.writeTxnSync(() => db.episodes.putSync(episode));

    return db.episodes.where().findAllSync().length;
  }

  @override
  Future<Episode?> loadEpisodeByIndex(int index) async {
    final db = await isar;

    final List<Episode> episodes = await db.episodes.where().findAll();

    if (episodes.length == index) return null;

    return episodes[index];
  }

  @override
  Future<void> clearDb() async {
    final db = await isar;

    await db.episodes.clear();
  }
}
