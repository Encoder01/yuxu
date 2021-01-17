import 'package:flutter/cupertino.dart';

class IsplayNotifier extends ValueNotifier<bool>{
  static ValueNotifier<bool> valueNotifier = ValueNotifier(false);

  IsplayNotifier(bool value) : super(value);

 static setFalse(){
    valueNotifier.value=false;
   // notifyListeners();
  }
  static setTrue(){
    valueNotifier.value=true;
   // notifyListeners();
  }
 static setToggle(){
    valueNotifier.value=!valueNotifier.value;
    //notifyListeners();
  }
}