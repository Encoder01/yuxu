import 'package:audioplayers/audio_cache.dart';
import 'package:mindfocus/Model/audio_model.dart';
import 'package:mindfocus/Model/playedFav.dart';

class FavoriController{
  static List<AudioModel> Favoriaudios=[];
  static List<Played> playedFav = [];

  static stopall(){
    Favoriaudios.forEach((element) {
      element.players.stop();
      element.players.release();
    });
    AudioCache().clearCache();
    Favoriaudios.clear();
  }

  static pause(){
    if(Favoriaudios.isNotEmpty){
      Favoriaudios.forEach((element) {
        element.players.pause();
      });
    }
  }

  static resume(){
    if(Favoriaudios.isNotEmpty){
      Favoriaudios.forEach((element) {
        element.players.resume();
      });
    }
  }

  static setVolume(String pID,double volume){
    Favoriaudios.singleWhere((element) => element.players.playerId==pID).players.setVolume(volume);
  }

  static bool getIsplay(String id) {
    bool isplay = false;
    playedFav.forEach((element) {
      if (element.id == id) {
        isplay = element.isPlay;
      }
    });
    print("Favori çalma durumu:"+isplay.toString());
    return isplay;
  }

  static bool setIsplay(String id, bool isplay) {
    playedFav.forEach((element) {
      if (element.id == id) {
        element.isPlay = isplay;
      }
    });

    return isplay;
  }

  static bool getHaveplay(String id) {
    bool isplay = false;
    playedFav.forEach((element) {
      if (element.id == id) {
        isplay = element.havePlay;
      }
    });
    return isplay;
  }

  static bool setHaveplay(String id, bool isplay) {
    playedFav.forEach((element) {
      if (element.id == id) {
        element.havePlay = isplay;
      }
    });
    return isplay;
  }
}