
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:mindfocus/Model/Audio.dart';
class PlayerController extends ChangeNotifier{
  static bool isEfect = true;
  static bool isMusic = true;
  static List<Audio> audios=[];
  static List<Audio> Players =[];

  static stop(String pID){
    PlayerController.audios.forEach((element) {
      if(element.id==pID){
     element.players.stop();
     element.players.release();
     AudioCache().clear(element.sesPath);
      }
    });
  }
  static stopall(){
    Players.forEach((element) {
      element.players.stop();
      element.players.release();
    });
    AudioCache().clearCache();
    Players.clear();
  }
  static pause(){
    Players.forEach((element) {
      element.players.pause();
    });
  }
  static resume(){
    Players.forEach((element) {
      element.players.resume();
    });
  }
  static setVolume(String pID,double volume){
    Players.singleWhere((element) => element.players.playerId==pID).players.setVolume(volume);
  }

}