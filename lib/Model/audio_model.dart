import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';



class AudioModel{
  String id;
  String icon1;
  String icon2;
  List<Color> color;
  String sesPath;
  double volume;
  bool visible;
  AudioPlayer players;
  AudioModel({this.id,this.volume,this.icon1,this.icon2,this.color,this.sesPath,this.visible,this.players});

}