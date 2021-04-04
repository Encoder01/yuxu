
import 'package:flutter/material.dart';

class CounterNotifier extends ValueNotifier<int> {
  static ValueNotifier<int> EfektSayiKontrol=ValueNotifier(0);

  CounterNotifier(int value) : super(value);
  static void increment() {
    EfektSayiKontrol.value++;
  }
  static void sifirla(){
  EfektSayiKontrol.value=0;
  }
  static void updateUI(){
    increment();
    decrement();
  }
  static void decrement() {
  EfektSayiKontrol.value--;
  }
}

