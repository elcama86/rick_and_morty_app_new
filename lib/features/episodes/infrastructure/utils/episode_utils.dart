import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EpisodeUtils {
  static MaterialColor colorBySeason(String episode) {
    String season = episode.substring(0, 3);

    switch (season) {
      case "S01":
        return Colors.blueGrey;
      case "S02":
        return Colors.purple;
      case "S03":
        return Colors.teal;
      case "S04":
        return Colors.indigo;
      case "S05":
        return Colors.cyan;
      default:
        return Colors.blueGrey;
    }
  }

  static String transformAirDate(String airDate) {
    DateTime transformDate = DateFormat('MMMM d, y').parse(airDate);
    DateFormat format = DateFormat.yMMMMd('es');

    return format.format(transformDate);
  }

  static String getSeason(String episode) {
    String season = episode.substring(0, 3).replaceFirst('S', '');

    if (season.startsWith('0')) {
      season = season.replaceFirst('0', '');
    }

    return season;
  }

  static String getEpisode(String episode) {
    String episodeNumber = episode.substring(3).replaceFirst('E', '');

    if (episodeNumber.startsWith('0')) {
      episodeNumber = episodeNumber.replaceFirst('0', '');
    }

    return episodeNumber;
  }
}
