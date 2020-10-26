import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';

class Audio{
  String id;
  String icon1;
  String icon2;
  List<Color> color;
  String sesPath;
  double volume;
  bool visible;
  AudioPlayer players;
  Audio({this.id,this.volume,this.icon1,this.icon2,this.color,this.sesPath,this.visible,this.players});

}