import 'package:flutter/cupertino.dart';

class IsplayNotifier extends ValueNotifier<bool>{
  static ValueNotifier<bool> efectPlayerNotifier = ValueNotifier(false);
  static ValueNotifier<bool> PlayerSuggs = ValueNotifier(false);
  static ValueNotifier<bool> Isfavori = ValueNotifier(false);
  static ValueNotifier<bool> IsEffect = ValueNotifier(false);
  static ValueNotifier<bool> IsSuggs = ValueNotifier(false);

  IsplayNotifier(bool value) : super(value);

 static setFalsePlay(){
    efectPlayerNotifier.value=false;
  }
  static setTruePlay(){
    efectPlayerNotifier.value=true;
  }
 static setTogglePlay(){
    efectPlayerNotifier.value=!efectPlayerNotifier.value;
  }

  static setToggleSugg(){
    PlayerSuggs.value=!PlayerSuggs.value;
  }

  static setFalseFavori(){
    Isfavori.value=false;
  }
  static setTrueFavori(){
    Isfavori.value=true;
  }

  static setFalseSugg(){
    IsSuggs.value=false;
  }
  static setTrueSugg(){
    IsSuggs.value=true;
  }

}