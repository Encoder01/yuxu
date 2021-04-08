// To parse this JSON data, do
//
//     final recommendModel = recommendModelFromJson(jsonString);

import 'dart:convert';

RecommendModel recommendModelFromJson(String str) => RecommendModel.fromJson(json.decode(str));

String recommendModelToJson(RecommendModel data) => json.encode(data.toJson());

class RecommendModel {
  RecommendModel({
    this.svgPath,
    this.sounds,
    this.color,
    this.id,
    this.hashTag,
    this.name,
  });

  String svgPath;
  Sounds sounds;
  int color;
  String id;
  String hashTag;
  String name;

  factory RecommendModel.fromJson(Map<String, dynamic> json) => RecommendModel(
    svgPath: json["svgPath"],
    sounds: Sounds.fromJson(json["sounds"]),
    color: json["Color"],
    id: json["Id"],
    hashTag: json["hashTag"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "svgPath": svgPath,
    "sounds": sounds.toJson(),
    "Color": color,
    "Id": id,
    "hashTag": hashTag,
    "Name": name,
  };
}

class Sounds {
  Sounds({
    this.soundPath,
    this.volumes,
    this.icons,
  });

  List<String> soundPath;
  List<int> volumes;
  List<String> icons;

  factory Sounds.fromJson(Map<String, dynamic> json) => Sounds(
    soundPath: List<String>.from(json["soundPath"].map((x) => x)),
    volumes: List<int>.from(json["volumes"].map((x) => x)),
    icons: List<String>.from(json["icons"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "soundPath": List<dynamic>.from(soundPath.map((x) => x)),
    "volumes": List<dynamic>.from(volumes.map((x) => x)),
    "icons": List<dynamic>.from(icons.map((x) => x)),
  };
}
