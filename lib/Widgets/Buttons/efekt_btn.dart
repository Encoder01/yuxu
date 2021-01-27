import 'dart:io';


import 'package:audio_manager/audio_manager.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindfocus/Controller/countProv.dart';
import 'package:mindfocus/Model/audio_model.dart';
import 'package:mindfocus/Model/ColorsPack.dart';
import 'package:mindfocus/Model/isplaynotifier.dart';
import 'package:mindfocus/Services/fade_out.dart';
import 'package:mindfocus/Widgets/Pages/main_page.dart';
import 'package:mindfocus/Controller/PlayerController.dart';
import 'package:easy_localization/easy_localization.dart';

void audioPlayerHandler(AudioPlayerState value) {
  if(value ==AudioPlayerState.PAUSED)
   {

     IsplayNotifier.setFalse();
   PlayerController.pause();
   }
  else if(value ==AudioPlayerState.PLAYING)
   {
     PlayerController.resume();
     IsplayNotifier.setTrue();}
  else if(value == AudioPlayerState.STOPPED)
   {
     PlayerController.stopall();
     IsplayNotifier.setFalse();}

}
class EfektButton extends StatefulWidget {
  String icon;
  List<Color> color = [ColorsPack.mixsbg, ColorsPack.mixsthmb];
  String icon2;
  String ses;
  bool visible;

  EfektButton({this.ses, this.icon, this.icon2, this.visible, this.color});

  @override
  _EfektButtonState createState() => _EfektButtonState(
      color: this.color, ses: this.ses, icon: this.icon, icon2: this.icon2, visible: this.visible);
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
  AudioModel _audio;
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
    _audio = new AudioModel(
        id: _player.playerId,
        players: _player,
        sesPath: ses,
        volume: volume,
        icon1: icon,
        color: color,
        visible: visible);
    _player.setReleaseMode(ReleaseMode.LOOP);
    _audioCache = AudioCache(fixedPlayer: _player);
    PlayerController.audios.add(_audio);
    super.initState();
  }
@override
  void dispose() {
   _player.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: CounterNotifier.sayiKontrol,
        builder: (context,  value, child) {
      return Padding(
        padding: const EdgeInsets.all(9.0),
        child: SizedBox(
          width: 100,
          child: Column(
            children: [
              StatefulBuilder(builder: (BuildContext context, setState) {
                _controller.addListener(() {
                  if (_controller.isAnimating) setState(() {});
                });
                return Transform.scale(
                  scale: scaleAnimation.value,
                  child: IconButton(
                      iconSize: 65,
                      onPressed: () {
                        if (!PlayerController.audios
                                .singleWhere((element) => element.id == _player.playerId)
                                .visible &&
                            value < 7) {
                          CounterNotifier.increment();

                          if (IsplayNotifier.valueNotifier.value == false && value > 1) {
                            FadeOut().FadeIn();
                          } else if (IsplayNotifier.valueNotifier.value == false) {
                            PlayerController.resume();
                          }
                          openMusic();
                          return;
                        }
                        if (PlayerController.audios
                            .singleWhere((element) => element.id == _player.playerId)
                            .visible) {
                          closeMusic();
                          CounterNotifier.decrement();
                          return;
                        }
                        if (value >= 6) {
                          // ignore: deprecated_member_use
                          Flushbar(
                            icon: ImageIcon(AssetImage('assets/logo.jpg'),color: Colors.blueAccent,),
                            backgroundColor: Colors.transparent,
                            barBlur:05 ,
                            flushbarStyle: FlushbarStyle.FLOATING,
                            flushbarPosition: FlushbarPosition.TOP,
                            title:  "Mindfocus",
                            message:  "toastEfekt".tr(),
                            duration:  Duration(seconds: 3),
                          )..show(context);
                          return;
                        }
                      },
                      icon: SvgPicture.asset(_audio.visible ? icon2 : icon)),
                );
              }),
              Visibility(
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: PlayerController.audios
                    .singleWhere((element) => element.id == _player.playerId)
                    .visible,
                child: StatefulBuilder(builder: (BuildContext context, setStates) {
                  return FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          color: color[0],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: color[1],
                            inactiveTrackColor: color[1].withOpacity(0.3),
                            trackShape: RectangularSliderTrackShape(),
                            trackHeight: 6.0,
                            thumbColor: color[1],
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                            overlayColor: color[1],
                            overlayShape: RoundSliderOverlayShape(overlayRadius: 18.0),
                          ),
                          child: Slider(
                            value: _audio.volume,
                            min: 0,
                            max: 100,
                            onChangeEnd: (value) {
                              PlayerController.audios.forEach((element) {
                                if (element.sesPath == _audio.sesPath) {
                                  element.volume = value;
                                }
                              });
                            },
                            onChanged: (double value) {
                              _player.setVolume(value / (ses == 'ses/Mix/mix_kalp.m4a' ? 10 : 100));
                              setStates(() {
                                _audio.volume = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      );
    });
  }

  double sess() {
    double ses;
    PlayerController.audios.forEach((element) {
      if (element.sesPath == _audio.sesPath) {
        ses = element.volume;
      }
    });
    return ses;
  }

  openMusic() async{
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

    PlayerController.Players.add(AudioModel(volume: volume, players: _player));
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
