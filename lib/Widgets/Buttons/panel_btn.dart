import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:mindfocus/Controller/countProv.dart';
import 'package:mindfocus/Controller/theme.dart';
import 'package:mindfocus/Model/isplaynotifier.dart';
import 'package:mindfocus/Services/fade_out.dart';
import 'package:mindfocus/Widgets/Dialogs/panel_dialog.dart';
import 'package:mindfocus/Widgets/Pages/settings_page.dart';
import 'package:mindfocus/Controller/PlayerController.dart';
import 'package:mindfocus/main.dart';


import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class PanelButton extends StatefulWidget {
  @override
  _PanelButtonState createState() => _PanelButtonState();
}

class _PanelButtonState extends State<PanelButton> with TickerProviderStateMixin {
  bool visible;
  AnimationController _controller;
  var scaleAnimation;
  final CountdownController controller = CountdownController();
  static bool isTimer = false;
  int seconds = 0;
  bool isPlaying = false;
  CounterNotifier counterNotifier;
  IsplayNotifier isplayNotifier;


  @override
  void initState() {
    counterNotifier = CounterNotifier(0);
    visible = false;
    _controller = new AnimationController(duration: new Duration(milliseconds: 650), vsync: this)
      ..addListener(() {
        setState(() {});
      });
    scaleAnimation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.linearToEaseOut));
    setupAudio();
    super.initState();
  }
  PlayMode playMode = AudioManager.instance.playMode;

  void setupAudio() {
    AudioManager.instance.onEvents((events, args) {
      print("event: $events -----  arg: $args");
      if(events==AudioManagerEvents.playstatus)
      {
        if (args) {
         IsplayNotifier.setTrue();
          controller.resume();
          PlayerController.resume();
        } else {
          IsplayNotifier.setFalse();
          controller.pause();
          PlayerController.pause();
        }
      }
    });
  }


  @override
  Widget build(BuildContext contexts) {
    return ValueListenableBuilder<int>(
      valueListenable: CounterNotifier.sayiKontrol,
        builder: (BuildContext context, value, Widget child) {
        if (value == 1 && !visible) {
          visible = true;
          IsplayNotifier.setTrue();
          AudioManager.instance.start("assets/ses/City/araba.m4a", "Mindfocus:Relax",desc:"notif".tr(),cover:"assets/logo.png");
          AudioManager.instance.updateNtf(IsplayNotifier.valueNotifier.value);
          _controller.forward();
        } else if (value == 0 && visible) {
          visible = false;
          IsplayNotifier.setFalse();
          AudioManager.instance.toPause();
          _controller.reverse();
        }
          return ValueListenableBuilder<bool>(
              valueListenable: IsplayNotifier.valueNotifier,
              builder: (BuildContext context, value, Widget child) {
              return Transform.scale(
                scale: scaleAnimation.value,
                child: Container(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      Column(
                        children: [
                          Visibility(
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            visible: isTimer,
                            child: Countdown(
                              controller: controller,
                              seconds: seconds,
                              build: (_, double time) {
                                if (time == SettingsPage.lowVolume) {
                                  FadeOut().fadeOut();
                                }
                                return Text(
                                  "${_printDuration(time.toInt())}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: darkmode ? Colors.white : Colors.black38),
                                );
                              },
                              interval: Duration(seconds: 1),
                              onFinished: () {
                                setState(() {
                                  isTimer = false;
                                  IsplayNotifier.setToggle();
                                  PlayerController.pause();

                                  PlayerController.Players.forEach((element) {
                                    element.players.setVolume(element.volume / 20);
                                  });
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  color: Colors.white.withOpacity(0.7)),
                              width: 180,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.timelapse),
                                    onPressed: () => _showTimerPickDialog(),
                                    iconSize: 32,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.volume_down),
                                    onPressed: () => showDialog(
                                        context: contexts,
                                        builder: (context) => PanelDialog()),
                                    iconSize: 32,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                        value? Icons.pause_circle_filled : Icons.play_arrow),
                                    onPressed: ()  {
                                      if (value) {
                                        IsplayNotifier.setToggle();
                                        controller.pause();
                                        PlayerController.pause();
                                        AudioManager.instance.updateNtf(false);
                                      } else {
                                        IsplayNotifier.setToggle();
                                        controller.resume();
                                       PlayerController.resume();
                                        AudioManager.instance.updateNtf(true);
                                      }
                                      setState(() {});
                                    },
                                    iconSize: 32,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          );

      }
    );
  }

  _showTimerPickDialog() {
    showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              content: Container(
                height: 250,
                child: CupertinoTimerPicker(
                  initialTimerDuration: Duration(seconds: seconds),
                  onTimerDurationChanged: (value) {
                    setState(() {
                      seconds = value.inSeconds;
                    });
                  },
                  mode: CupertinoTimerPickerMode.hm,
                ),
              ),
              actions: <Widget>[
                CupertinoButton(
                  child: Text(isTimer ? 'res'.tr() : 'cancel'.tr()),
                  onPressed: () {
                    if (isTimer) {
                      seconds = 0;
                      isTimer = false;
                      setState(() {});
                    }
                    Navigator.pop(context);
                  },
                ),
                CupertinoButton(
                  child: Text('start',style: TextStyle(color: Colors.red),).tr(),
                  onPressed: () {
                    setState(() {

                      if (IsplayNotifier.valueNotifier.value &&seconds>=59)
                      {  isTimer = true;
                      controller.restart();}
                      else if(seconds>=59) {
                        isTimer = true;
                        controller.restart();
                        controller.pause();
                      }
                      else if(seconds==0)
                        isTimer=false;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  String _printDuration(int time) {
    Duration duration = Duration(seconds: time);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
