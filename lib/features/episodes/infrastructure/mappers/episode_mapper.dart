import 'package:rick_and_morty_app/features/episodes/episodes.dart';

class EpisodeMapper {
  static Episode resultToEntity(Result result) => Episode(
        id: result.id,
        name: result.name,
        airDate: result.airDate,
        episode: result.episode,
        characters: List<String>.from(result.characters.map((c) => c)),
      );
      
  static Episode episodeDetailsToEntity(EpisodeDetails episodeDetails) =>
      Episode(
        id: episodeDetails.id,
        name: episodeDetails.name,
        airDate: episodeDetails.airDate,
        episode: episodeDetails.episode,
        characters: List<String>.from(episodeDetails.characters.map((c) => c)),
      );
}
