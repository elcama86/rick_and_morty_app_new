import 'package:isar/isar.dart';

part 'episode.g.dart';

@collection
class Episode {
  Id isarId = Isar.autoIncrement;
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characters;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
  });
}
