// To parse this JSON data, do
//
//     final suggestionsModel = suggestionsModelFromJson(jsonString);

import 'dart:convert';

SuggestionsModel suggestionsModelFromJson(String str) => SuggestionsModel.fromJson(json.decode(str));

String suggestionsModelToJson(SuggestionsModel data) => json.encode(data.toJson());

class SuggestionsModel {
  SuggestionsModel({
    this.id,
    this.name,
    this.sounds,
    this.volume,
    this.color,
    this.svgPath,
  });

  String id;
  String name;
  Sounds sounds;
  int volume;
  int color;
  String svgPath;

  factory SuggestionsModel.fromJson(Map<String, dynamic> json) => SuggestionsModel(
    id: json["ID"],
    name: json["name"],
    sounds: Sounds.fromJson(json["sounds"]),
    volume: json["Volume"],
    color: json["Color"],
    svgPath: json["svgPath"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "name": name,
    "sounds": sounds.toJson(),
    "Volume": volume,
    "Color": color,
    "svgPath": svgPath,
  };
}

class Sounds {
  Sounds({
    this.icons,
    this.volume,
    this.soundPath,
  });

  List<String> icons;
  List<int> volume;
  List<String> soundPath;

  factory Sounds.fromJson(Map<String, dynamic> json) => Sounds(
    icons: List<String>.from(json["icons"].map((x) => x)),
    volume: List<int>.from(json["Volume"].map((x) => x)),
    soundPath: List<String>.from(json["soundPath"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "icons": List<dynamic>.from(icons.map((x) => x)),
    "Volume": List<dynamic>.from(volume.map((x) => x)),
    "soundPath": List<dynamic>.from(soundPath.map((x) => x)),
  };
}
