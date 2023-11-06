// To parse this JSON data, do
//
//     final characterDetails = characterDetailsFromJson(jsonString);

import 'dart:convert';

import 'characters_response.dart';

CharacterDetails characterDetailsFromJson(String str) => CharacterDetails.fromJson(json.decode(str));

String characterDetailsToJson(CharacterDetails data) => json.encode(data.toJson());

class CharacterDetails {
    final int id;
    final String name;
    final String status;
    final String species;
    final String type;
    final String gender;
    final LocationOrigin origin;
    final LocationOrigin location;
    final String image;
    final List<String> episode;
    final String url;
    final DateTime created;

    CharacterDetails({
        required this.id,
        required this.name,
        required this.status,
        required this.species,
        required this.type,
        required this.gender,
        required this.origin,
        required this.location,
        required this.image,
        required this.episode,
        required this.url,
        required this.created,
    });

    factory CharacterDetails.fromJson(Map<String, dynamic> json) => CharacterDetails(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        origin: LocationOrigin.fromJson(json["origin"]),
        location: LocationOrigin.fromJson(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode": List<dynamic>.from(episode.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
    };
}


