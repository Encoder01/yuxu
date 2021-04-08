import 'dart:async';
import 'dart:io';

import 'package:audio_manager/audio_manager.dart';

import 'package:mindfocus/Controller/PlayerController.dart';
import 'package:mindfocus/Widgets/SettingsPages/settings_page.dart';

class FadeOut {
  fadeOut() {
    double _start = SettingsPage.lowVolume * 10;
    const oneSec = const Duration(milliseconds: 100);
    new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start < 1) {
          timer.cancel();
        } else {
          _start = _start - 1;
          PlayerController.Players.forEach((element) {
            element.players.setVolume(SettingsPage.lowVolume == 20
                ? _start / 200
                : SettingsPage.lowVolume == 15
                    ? _start / 150
                    : _start / 100);
          });
        }
      },
    );
  }
  fadefadeOut() {
    double _start = 300;
    const oneSec = const Duration(milliseconds: 90);
    if(Platform.isAndroid){
      AudioManager.instance.getCurrentVolume().then((value) {
        double fvolume=value;
        new Timer.periodic(
          oneSec,
              (Timer timer) {
            fvolume= fvolume-(value*0.1);
            if (fvolume < 0) {
              timer.cancel();
              PlayerController.pause();
              AudioManager.instance.setVolume(value);
            } else {
              _start = _start - 1;
              AudioManager.instance.setVolume(fvolume);
            }
          },
        );
      });
    }else{
      PlayerController.pause();
    }
  }

  // ignore: non_constant_identifier_names
  FadeIn() {
    double _start = 0;
    double fVolume = 0.2;
    const oneSec = const Duration(milliseconds: 150);
    if(Platform.isAndroid){
      AudioManager.instance.getCurrentVolume().then((value) {
        AudioManager.instance.setVolume(fVolume,showVolume: false);
        PlayerController.resume();
        new Timer.periodic(oneSec, (Timer timer) {
          print(value);
          fVolume += (value*0.1);
          if (value < fVolume) {
            timer.cancel();
          } else {
            _start = _start + 1;
            AudioManager.instance.setVolume(fVolume);
          }
        });
      });
    }else{
      PlayerController.resume();
    }
  }
}
