import 'dart:io';

import 'package:audio_manager/audio_manager.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:mindfocus/Controller/countProv.dart';
import 'package:mindfocus/Model/Audio.dart';
import 'package:mindfocus/Model/ColorsPack.dart';
import 'package:mindfocus/Services/fade_out.dart';
import 'package:mindfocus/Services/gets.dart';
import 'package:mindfocus/Widgets/Pages/main_page.dart';
import 'package:mindfocus/Controller/PlayerController.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

void audioPlayerHandler(AudioPlayerState value) => print('state => $value');
class EfektButton extends StatefulWidget {
  String icon;
  List<Color> color = [ColorsPack.mixsbg, ColorsPack.mixsthmb];
  String icon2;
  String ses;
  bool visible;

  EfektButton({this.ses, this.icon, this.icon2, this.visible, this.color});

  @override
  _EfektButtonState createState() =>
      _EfektButtonState(
          color: this.color,
          ses: this.ses,
          icon: this.icon,
          icon2: this.icon2,
          visible: this.visible);
}

class _EfektButtonState extends State<EfektButton>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  List<Color> color;
  String icon;
  String icon2;
  String ses;
  bool visible;
  double volume;

  _EfektButtonState({this.color, this.ses, this.icon, this.icon2, this.visible});
  AudioPlayer _player;
  Audio _audio;
  AudioCache _audioCache;
  AnimationController _controller;
  var scaleAnimation;

  @override
  void initState() {
    _controller = new AnimationController(duration: new Duration(milliseconds: 700), vsync: this);
    scaleAnimation = new Tween(
      begin: 0.8,
      end: 1.0,
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    volume = 50;
    visible = false;
    _player = new AudioPlayer();
    _audio = new Audio(
        id: _player.playerId,
        players: _player,
        sesPath: ses,
        volume: volume,
        icon1: icon,
        color: color,
        visible: visible);
    _audioCache = AudioCache(fixedPlayer: _player);
    PlayerController.audios.add(_audio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterNotifier>(
        builder: (context, CounterNotifier notifier, child) {
        return Padding(
          padding: const EdgeInsets.all(9.0),
          child: SizedBox(
            width: 100,
            child: Column(
              children: [
                StatefulBuilder(
                    builder: (BuildContext context, setState){
                      _controller.addListener(() {
                        if (_controller.isAnimating) setState(() {});
                      });
                    return Transform.scale(
                      scale: scaleAnimation.value,
                      child: IconButton(
                          iconSize: 65,
                          onPressed: () {
                            if (!PlayerController.audios.singleWhere((element) =>
                            element.id == _player.playerId).visible && notifier.sayiKontrol < 7)
                            {
                              openMusic();
                              notifier.increment();
                              return;
                            }
                            if (PlayerController.audios.singleWhere((element) =>
                            element.id == _player.playerId).visible)
                            {
                              closeMusic();
                              notifier.decrement();
                              return;
                            }
                            if ( notifier.sayiKontrol >= 6) {
                              Gets().showSnack("Mindfocus", "toastEfekt".tr());
                              return;
                            }
                          },
                          icon: SvgPicture.asset(_audio.visible ? icon2 : icon)),
                    );
                  }
                ),
                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: PlayerController.audios
                      .singleWhere((element) => element.id == _player.playerId)
                      .visible,
                  child: Container(
                    height: 21,
                    decoration:
                    BoxDecoration(color: color[0], borderRadius: BorderRadius.circular(30)),
                    child: FlutterSlider(
                      onDragCompleted: (handlerIndex, lowerValue, upperValue)
                      {
                        PlayerController.audios.forEach((element) {
                          if(element.sesPath==_audio.sesPath){
                            element.volume=lowerValue;
                          }
                        });
                      },
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        _player.setVolume(lowerValue / (ses=='ses/Mix/mix_kalp.m4a'?10:100));
                        PlayerController.audios.forEach((element) {
                          if(element.sesPath==_audio.sesPath){
                            element.volume=lowerValue;
                          }
                        });
                      },
                      handlerWidth: 20,
                      handlerHeight: 20,
                      tooltip: FlutterSliderTooltip(
                        disabled: true,
                      ),
                      trackBar: FlutterSliderTrackBar(
                        activeTrackBar:
                        BoxDecoration(color: color[1], borderRadius: BorderRadius.circular(50)),
                      ),
                      handler: FlutterSliderHandler(
                        decoration: BoxDecoration(),
                        child: Material(
                          type: MaterialType.circle,
                          color: color[1],
                          elevation: 3,
                          child: Container(
                            width: 17,
                            height: 20,
                          ),
                        ),
                      ),
                      max: 100,
                      min: 0,
                      values: [
                      sess()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
double sess(){
    double ses;
  PlayerController.audios.forEach((element) {
    if(element.sesPath==_audio.sesPath){
      ses = element.volume;
    }
  });
  return ses;
}
  openMusic() {
    if (MainPage.isPlay == false) {
     FadeOut().fadefadeIn();
    }

    PlayerController.audios.singleWhere((element) =>
    element.id == _player.playerId).visible =
    !PlayerController.audios.singleWhere((element) =>
    element.id == _player.playerId).visible;
    if (!kIsWeb && Platform.isIOS) {
      _player.monitorNotificationStateChanges(audioPlayerHandler);
    }
    _audioCache.loop(ses,volume: PlayerController.audios.singleWhere((element) =>
    element.id == _player.playerId).volume /(_audio.sesPath=='ses/Mix/mix_kalp.m4a'?10:100));

    _audio.visible = PlayerController.audios.singleWhere((element) =>
    element.id == _player.playerId).visible;

    PlayerController.Players.add(Audio(volume: volume, players: _player));
    MainPage.isPlay = true;

    AudioManager.instance.updateNtf(PlayerController.isEfect);
    _controller.forward();
    if (_controller.isCompleted) _controller.stop();
  }

  closeMusic() {
    PlayerController.audios.singleWhere((element) =>
    element.id == _player.playerId).volume = 50.0;

    PlayerController.audios.singleWhere((element) =>
    element.id == _player.playerId).visible = !PlayerController.audios.singleWhere((element) =>
    element.id == _player.playerId).visible;

    _controller.reverse();
    _audio.visible =PlayerController.audios.singleWhere((element) =>
    element.id == _player.playerId).visible;

    _player.stop();
    _player.release();
    _audioCache.clear(ses);
    PlayerController.Players.removeWhere((element) => element.players.playerId == _player.playerId);
    if (_controller.isCompleted) _controller.stop();
  }


  @override
  bool get wantKeepAlive => true;
}
