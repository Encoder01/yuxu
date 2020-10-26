import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Gets {
  showSnack(String title, String message) {
    Get.snackbar(title, message,
        icon: Image.asset("assets/logo.png",width: 45,height: 45,),
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        snackStyle: SnackStyle.FLOATING);
  }
}
