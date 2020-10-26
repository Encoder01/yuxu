import 'package:flutter/cupertino.dart';


class CounterNotifier extends ChangeNotifier {
  int _sayiKontrol;

CounterNotifier(){
  _sayiKontrol=0;
}


  int get sayiKontrol => _sayiKontrol;


  void increment() {
    _sayiKontrol++;
    notifyListeners();
  }
  void sifirla(){
  _sayiKontrol=0;
  notifyListeners();
  }
  void updateUI(){
  _sayiKontrol=_sayiKontrol;
  notifyListeners();
  }
  void decrement() {
  _sayiKontrol--;
  notifyListeners();
  }
}

