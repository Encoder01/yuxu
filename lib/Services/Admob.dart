import 'dart:io';

import 'package:firebase_admob/firebase_admob.dart';
const String testDevice = 'YOUR_DEVICE_ID';

class AdmobService{
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  BannerAd _bannerAd;
  NativeAd _nativeAd;
  InterstitialAd _interstitialAd;
  int _coins = 0;

  BannerAd get bannerAd => _bannerAd;

  set bannerAd(BannerAd value) {
    _bannerAd = value;
  }

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
      },
    );
  }

  NativeAd createNativeAd() {
    return NativeAd(
      adUnitId: NativeAd.testAdUnitId,
      factoryId: 'adFactoryExample',
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("$NativeAd event $event");
      },
    );
  }
  String getAdMobId(){
    if(Platform.isIOS){
      return 'ca-app-pub-2182756097973140~5592479163';//değişcek
    }else if(Platform.isAndroid){
      return 'ca-app-pub-3940256099942544~3347511713';
    }
    return null;
  }
  String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-2182756097973140/6606177931';//değişcek
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-1109506344415818/7348776987';
    }
    return null;
  }
  String getinterstitialAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-2182756097973140/8027070819';//değişcek
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2182756097973140/9973372023';//değişcek
    }
    return null;
  }
  String getNativeAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-2182756097973140/5923829260';//değişcek
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-2182756097973140/4465237936';//değişcek
    }
    return null;
  }

  NativeAd get nativeAd => _nativeAd;

  set nativeAd(NativeAd value) {
    _nativeAd = value;
  }

  InterstitialAd get interstitialAd => _interstitialAd;

  set interstitialAd(InterstitialAd value) {
    _interstitialAd = value;
  }

  int get coins => _coins;

  set coins(int value) {
    _coins = value;
  }
}