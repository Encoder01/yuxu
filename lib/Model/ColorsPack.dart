
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mindfocus/Controller/theme.dart';
import 'package:mindfocus/Widgets/Pages/settings_page.dart';
import 'package:mindfocus/main.dart';
class ColorsPack{



  static Color get label => darkmode?Colors.white:Colors.black;
  static Color get label2 => darkmode?Colors.white70:Colors.white;


  static Color get doga => darkmode?Color(0xFF083024):Color(0xFF1BBC9B);
  static Color get hava => darkmode?Color(0xFF09303A):Color(0xFF1D88C3);
  static Color get sehir => darkmode?Color(0xFF320707):Color(0xFFEF4836);
  static Color get mind =>  darkmode?Color(0xFF30200C):Color(0xFFf5ab35);
  static Color get mix =>  darkmode?Color(0xFF2A1237):Color(0xFF9E42CE);
  static Color get music =>  darkmode?Color(0xFF1E2147):Color(0xFF8C9EFF);
  static Color get settngs =>  darkmode?Color(0xFF2A1237):Colors.deepPurpleAccent;

  static Color get dogalight => darkmode?Color(0xFF020C09):Color(0xFF331BBC9B);
  static Color get havalight => darkmode?Color(0xFF020A0C):Color(0xFF3322A7F0);
  static Color get sehirlight =>  darkmode?Color(0xFF0C0303):Color(0xFF33EF4836);
  static Color get mindlight => darkmode?Color(0xFF0C0803):Color(0xFF33F5AB35);
  static Color get mixlight =>  darkmode?Color(0xFF05070C):Color(0xFF339E42CE);
  static Color get musiclight =>  darkmode?Color(0xFF12142B):Color(0xFF408C9EFF);
  static Color get settngslight =>darkmode?Color(0xFF0D0612):Color(0xFF32BF55EC);

  static Color get dogasbg =>  darkmode?Color(0xFF093323):Color(0xFF28E5AF);
  static Color get havasbg =>  darkmode?Color(0xFF082833):Color(0xFF28BDE5);
  static Color get sehirsbg => darkmode?Color(0xFF330E0C):Color(0xFFE53939);
  static Color get mindsbg =>  darkmode?Color(0xFF33220C):Color(0xFFE59C33);
  static Color get mixsbg => darkmode?Color(0xFF8271333):Color(0xFFB455E5);
  static Color get musicsbg =>  darkmode?Color(0xFFBC7986CB):Color(0xFF8C9EFF);

  static Color get dogathmb =>  !darkmode?Color(0xFF1BBC9B):Color(0xFF1DA388);
  static Color get havathmb =>  !darkmode?Color(0xFF1D88C3):Color(0xFF288AC1);
  static Color get sehirthmb => !darkmode?Color(0xFFEF4836):Color(0xFFBF392A);
  static Color get mindsthmb =>  !darkmode?Color(0xFFf5ab35):Color(0xFFBC8327);
  static Color get mixsthmb => !darkmode?Color(0xFF9E42CE):Color(0xFFAE49E3);
  static Color get musicthmb =>  !darkmode?Color(0xFFCB475EFF):Color(0xFF8C9EFF);


}