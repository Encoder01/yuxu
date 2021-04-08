// To parse this JSON data, do
//
//     final dailymixModel = dailymixModelFromJson(jsonString);

import 'dart:convert';

DailyMixModel dailymixModelFromJson(String str) => DailyMixModel.fromJson(json.decode(str));

String dailymixModelToJson(DailyMixModel data) => json.encode(data.toJson());

class DailyMixModel {
  DailyMixModel({
    this.svgPath,
    this.sounds,
    this.color,
    this.id,
    this.dayShow,
    this.name,
  });

  String svgPath;
  Sounds sounds;
  int color;
  String id;
  String dayShow;
  String name;

  factory DailyMixModel.fromJson(Map<String, dynamic> json) => DailyMixModel(
    svgPath: json["svgPath"],
    sounds: Sounds.fromJson(json["sounds"]),
    color: json["Color"],
    id: json["Id"],
    dayShow: json["dayShow"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "svgPath": svgPath,
    "sounds": sounds.toJson(),
    "Color": color,
    "Id": id,
    "dayShow": dayShow,
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
