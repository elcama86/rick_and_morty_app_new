// To parse this JSON data, do
//
//     final episodesResponse = episodesResponseFromJson(jsonString);

import 'dart:convert';

EpisodesResponse episodesResponseFromJson(String str) => EpisodesResponse.fromJson(json.decode(str));

String episodesResponseToJson(EpisodesResponse data) => json.encode(data.toJson());

class EpisodesResponse {
    final Info info;
    final List<Result> results;

    EpisodesResponse({
        required this.info,
        required this.results,
    });

    factory EpisodesResponse.fromJson(Map<String, dynamic> json) => EpisodesResponse(
        info: Info.fromJson(json["info"]),
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Info {
    final int count;
    final int pages;
    final String? next;
    final String? prev;

    Info({
        required this.count,
        required this.pages,
        required this.next,
        required this.prev,
    });

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"] ?? '',
        prev: json["prev"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
    };
}

class Result {
    final int id;
    final String name;
    final String airDate;
    final String episode;
    final List<String> characters;
    final String url;
    final DateTime created;

    Result({
        required this.id,
        required this.name,
        required this.airDate,
        required this.episode,
        required this.characters,
        required this.url,
        required this.created,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        characters: List<String>.from(json["characters"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "episode": episode,
        "characters": List<dynamic>.from(characters.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
    };
}
