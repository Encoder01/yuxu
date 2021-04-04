import 'package:audioplayers/audio_cache.dart';
import 'package:mindfocus/Model/audio_model.dart';
import 'package:mindfocus/Model/playedFav.dart';

class SuggstionController{
  static List<AudioModel> Suggestionaudios=[];
  static List<Played> playedSuggs = [];

  static stopall(){
    Suggestionaudios.forEach((element) {
      element.players.stop();
      element.players.release();
    });
    AudioCache().clearCache();
    Suggestionaudios.clear();
  }

  static pause(){
    if(Suggestionaudios.isNotEmpty){
      Suggestionaudios.forEach((element) {
        element.players.pause();
      });
    }
  }

  static resume(){
    if(Suggestionaudios.isNotEmpty){
      Suggestionaudios.forEach((element) {
        element.players.resume();
      });
    }
  }


  static bool getIsplay(String id) {
    bool isplay = false;
    playedSuggs.forEach((element) {
      if (element.id == id) {
        isplay = element.isPlay;
      }
    });
    print("Suggs çalma durumu:"+isplay.toString());
    return isplay;
  }

  static bool setIsplay(String id, bool isplay) {
    playedSuggs.forEach((element) {
      if (element.id == id) {
        element.isPlay = isplay;
      }
    });

    return isplay;
  }

  static bool getHaveplay(String id) {
    bool isplay = false;
    playedSuggs.forEach((element) {
      if (element.id == id) {
        isplay = element.havePlay;
      }
    });
    return isplay;
  }

  static bool setHaveplay(String id, bool isplay) {
    playedSuggs.forEach((element) {
      if (element.id == id) {
        element.havePlay = isplay;
      }
    });
    return isplay;
  }
}