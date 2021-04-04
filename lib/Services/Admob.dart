/*
import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';

class AdmobService{

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    childDirected: false,
     // or MobileAdGender.female, MobileAdGender.unknown
    testDevices: <String>["37b1da9d-b48c-4103-a393-2e095e734bd6"], // Android emulators are considered test devices
  );

  BannerAd myBanner;

  void showBanner(){
    myBanner= BannerAd(
      adUnitId: getBannerID(),
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
    myBanner
    ..load()
    ..show(anchorOffset: 50,anchorType: AnchorType.bottom);
  }
  void removeBanner(){
    myBanner?.dispose();
    myBanner=null;
  }

   getAPPID(){
    if(Platform.isAndroid){
      return "ca-app-pub-1109506344415818~5474983185";
    }else if(Platform.isIOS){
      return "ca-app-pub-1109506344415818~8004702664";
    }
  }getBannerID(){
    if(Platform.isAndroid){
      return "ca-app-pub-1109506344415818/7348776987";
    }else if(Platform.isIOS){
      return "ca-app-pub-1109506344415818/2803814043";
    }
  }

}*/