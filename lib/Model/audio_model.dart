import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';

class AudioModel{
  String id;
  String iconFav;
  String iconEdit;
  List<Color> color;
  String sesPath;
  double volume;
  bool visible;
  AudioPlayer players;
  AudioModel({this.id,this.volume,this.iconFav,this.iconEdit,this.color,this.sesPath,this.visible,this.players});
}