

import 'package:audioplayers/audio_cache.dart';
import 'package:mindfocus/Model/audio_model.dart';

import 'countProv.dart';
class PlayerController  {
  static List<AudioModel> audios=[];
  static List<AudioModel> Players =[];

  static stop(String pID){
    PlayerController.audios.forEach((element) {
      if(element.id==pID){
     element.players.stop();
      }
    });
  }
  static stopall(){
    Players.forEach((element) {
      element.players.stop();
      element.players.release();
    });
    AudioCache().clearCache();
    Players.forEach((element) {
      audios
          .singleWhere((elementaudio) =>
      elementaudio.id ==
          element.players.playerId)
          .visible = false;
    });
    Players.clear();
    CounterNotifier.sifirla();
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