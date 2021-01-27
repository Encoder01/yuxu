
import 'package:flutter/material.dart';

class CounterNotifier extends ValueNotifier<int> {
  static ValueNotifier<int> sayiKontrol=ValueNotifier(0);

  CounterNotifier(int value) : super(value);




  static void increment() {
    sayiKontrol.value++;
    print("sayiKontrol.value*************************");
  //  notifyListeners();
  }
  static void sifirla(){
  sayiKontrol.value=0;
//notifyListeners();
  }
  static void updateUI(){
    increment();
    decrement();
  //notifyListeners();
  }
  static void decrement() {
  sayiKontrol.value--;
 // notifyListeners();
  }
}

