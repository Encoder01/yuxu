import 'dart:io';

import 'package:audio_manager/audio_manager.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindfocus/Bloc/favplayer_bloc.dart';
import 'package:mindfocus/Controller/FavoriController.dart';
import 'package:mindfocus/Controller/SuggestController.dart';
import 'package:mindfocus/Controller/countProv.dart';
import 'package:mindfocus/Model/audio_model.dart';
import 'package:mindfocus/Services/ColorsPack.dart';
import 'package:mindfocus/Controller/isplaynotifier.dart';
import 'package:mindfocus/Services/fade_out.dart';
import 'package:mindfocus/Controller/PlayerController.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mindfocus/Widgets/Pages/favorite_page.dart';
import 'package:mindfocus/Widgets/Pages/suggestion_page.dart';



class EfektButton extends StatefulWidget {
  String icon;
  List<Color> color = [ColorsPack.mixsbg, ColorsPack.mixsthmb];
  String icon2;
  String iconFav;
  String iconEdit;
  String ses;
  bool visible;

  EfektButton({this.ses, this.icon, this.icon2,this.iconFav,this.iconEdit, this.visible, this.color});

  @override
  _EfektButtonState createState() => _EfektButtonState(
      color: this.color,
      ses: this.ses,
      icon: this.icon,
      icon2: this.icon2,
      iconEdit: this.iconEdit,
      iconFav: this.iconFav,
      visible: this.visible);
}

class _EfektButtonState extends State<EfektButton>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  List<Color> color;
  String icon;
  String icon2;
  String iconFav;
  String iconEdit;
  String ses;
  bool visible;
  double volume;

  _EfektButtonState({this.color, this.ses, this.icon, this.icon2,this.iconFav,this.iconEdit, this.visible});

  AudioPlayer _player;
  AudioModel _audio;
  AudioCache _audioCache;
  AnimationController _controller;
  var scaleAnimation;

  @override
  void initState() {
    _controller =
        new AnimationController(duration: new Duration(milliseconds: 700), vsync: this);
    scaleAnimation = new Tween(
      begin: 0.8,
      end: 0.9,
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    volume = 50;
    visible = false;
    _player = new AudioPlayer();
    _audio = new AudioModel(
        id: _player.playerId,
        players: _player,
        sesPath: ses,
        volume: volume,
        iconFav: iconFav,
        iconEdit: iconEdit,
        color: color,
        visible: visible);
    _player.setReleaseMode(ReleaseMode.LOOP);
    _audioCache = AudioCache(fixedPlayer: _player);
    PlayerController.audios.add(_audio);
    _controller.addListener(() {
      if (_controller.isAnimating) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _player.stop();
    _player.dispose();
    _audioCache.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: CounterNotifier.EfektSayiKontrol,
        builder: (context, value, child) {
          if (!PlayerController.audios
              .singleWhere((element) => element.id == _player.playerId)
              .visible) {
            _controller.reverse();
          }
          return Padding(
            padding: const EdgeInsets.all(9.0),
            child: SizedBox(
              width: 100,
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: IconButton(
                    iconSize: 75,
                    onPressed: () {
                      if(IsplayNotifier.Isfavori.value==false&&IsplayNotifier.IsSuggs.value==false){
                        if (!PlayerController.audios.singleWhere(
                                (element) => element.id == _player.playerId).visible&&value<7)
                        {
                          if (IsplayNotifier.efectPlayerNotifier.value == false && value>1)
                          {
                            FadeOut().FadeIn();
                          }
                          else if (IsplayNotifier.efectPlayerNotifier.value == false)
                          {
                            PlayerController.resume();
                          }
                          openMusic();
                          return;
                        }
                      }
                      else{
                        showDialog(
                          context: context,
                          builder: (contexts) => CupertinoAlertDialog(
                            content: Text("Your favorite list will be stopped, are you sure",
                              style: TextStyle(fontSize: 18),),
                            actions: [
                              CupertinoButton(
                                  child: Text(
                                    "no",
                                  ).tr(),
                                  onPressed: () => Navigator.pop(context)),
                              CupertinoButton(
                                  child: Text(
                                    "yes",
                                    style: TextStyle(fontSize: 16,color: Colors.red),
                                  ).tr(),
                                  onPressed: () {
                                    if(IsplayNotifier.Isfavori.value){
                                      FavoriController.playedFav.forEach((element) {
                                        element.isPlay = false;
                                        element.havePlay = false;
                                      });
                                      FavoritePage.currentPlay = false;
                                      FavoriController.stopall();
                                      IsplayNotifier.setFalseFavori();
                                      BlocProvider.of<FavplayerBloc>(context).add(FetchPlayerEvent(
                                        isplayed: false,
                                      ));
                                    }else if(IsplayNotifier.IsSuggs.value){
                                      SuggstionController.playedSuggs.forEach((element) {
                                        element.isPlay = false;
                                        element.havePlay = false;
                                      });
                                      SuggestionPage.currentPlay = false;
                                      SuggstionController.stopall();
                                      IsplayNotifier.setFalseSugg();
                                      IsplayNotifier.setToggleSugg();
                                    }
                                    openMusic();
                                    Navigator.pop(context);
                                  }),
                            ],
                          ),
                        );
                        return;
                      }
                      if (PlayerController.audios.singleWhere((element) =>
                      element.id == _player.playerId).visible) {
                        closeMusic();
                        CounterNotifier.decrement();
                        return;
                      }
                      if (value >= 6) {
                        Flushbar(
                          icon: ImageIcon(
                            AssetImage('assets/logo.jpg'),
                            color: Colors.blueAccent,
                          ),
                          backgroundColor: Colors.transparent,
                          barBlur: 05,
                          flushbarStyle: FlushbarStyle.FLOATING,
                          flushbarPosition: FlushbarPosition.TOP,
                          title: "Mindfocus",
                          message: "toastEfekt".tr(),
                          duration: Duration(seconds: 3),
                        )..show(context);
                        return;
                      }
                    },
                    icon: SvgPicture.asset(_audio.visible ? icon2 : icon)),
              ),
            ),
          );
        });
  }
    openMusic() async {
      CounterNotifier.increment();
    PlayerController.audios
            .singleWhere((element) => element.id == _player.playerId)
            .visible =
        !PlayerController.audios
            .singleWhere((element) => element.id == _player.playerId)
            .visible;

    _audioCache.loop(ses,
        volume: PlayerController.audios
                .singleWhere((element) => element.id == _player.playerId)
                .volume /
            (_audio.sesPath == 'ses/Mix/mix_kalp.m4a' ? 10 : 100));

    _audio.visible = PlayerController.audios
        .singleWhere((element) => element.id == _player.playerId)
        .visible;
    PlayerController.Players.add(AudioModel(volume: volume, players: _player,iconFav: iconFav));
    AudioManager.instance.updateNtf(true);
    _controller.forward();
    if (_controller.isCompleted) _controller.stop();
  }

  closeMusic() {
    PlayerController.audios
        .singleWhere((element) => element.id == _player.playerId)
        .volume = 50.0;

    PlayerController.audios
            .singleWhere((element) => element.id == _player.playerId)
            .visible =
        !PlayerController.audios
            .singleWhere((element) => element.id == _player.playerId)
            .visible;

    _controller.reverse();
    _audio.visible = PlayerController.audios
        .singleWhere((element) => element.id == _player.playerId)
        .visible;

    _player.stop();
    _player.release();
    _audioCache.clear(ses);
    PlayerController.Players.removeWhere(
        (element) => element.players.playerId == _player.playerId);
    if (_controller.isCompleted) _controller.stop();
  }

  @override
  bool get wantKeepAlive => true;
}
