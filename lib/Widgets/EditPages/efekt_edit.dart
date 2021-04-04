import 'dart:math';
import 'package:audio_manager/audio_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:hive/hive.dart';
import 'package:mindfocus/Services/fade_out.dart';
import 'package:mindfocus/Widgets/Pages/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:mindfocus/Controller/PlayerController.dart';
import 'package:mindfocus/Controller/countProv.dart';
import 'package:mindfocus/Model/favorites.dart';
import 'package:mindfocus/Model/favorites_model.dart';
import 'package:mindfocus/Controller/isplaynotifier.dart';
import 'package:mindfocus/Services/ColorsPack.dart';
import 'package:mindfocus/Services/authentication.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:uuid/uuid.dart';

class PanelDialog extends StatefulWidget {
   static CountdownController controller = CountdownController();
   static bool isTimer = false;
   static int seconds = 0;
  @override
  _PanelDialogState createState() => _PanelDialogState();
}

class _PanelDialogState extends State<PanelDialog> {



  PlayMode playMode = AudioManager.instance.playMode;
  TextEditingController _textFieldController = TextEditingController();
  bool favName = false;
  User user;
  @override
  void initState() {
    user = context.read<Authentication>().getUSer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF08123A),
        body: Stack(
          children: [
            Positioned(
              top: 50,
              left: 40,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      CounterNotifier.updateUI();
                    },
                    iconSize: 32,
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 150,
                right: 0,
                child: Image.asset("assets/signpage/Vector5.png")),
            Positioned(
                top: 100,
                left: 0,
                child: Image.asset("assets/signpage/Vector6.png")),
            Positioned(
                bottom: 0,
                child: Image.asset("assets/signpage/Vector1.png")),
            Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset("assets/signpage/Vector2.png")),
            Positioned(
                top: 0,
                right: 0,
                child: Image.asset("assets/signpage/Vector3.png")),
            Positioned(
                top: 0,
                right: 0,
                child: Image.asset("assets/signpage/Vector4.png")),

            Positioned(
              left: 30,
              right: 30,
              bottom: 5,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 380,
                      child: ListView.builder(
                        itemCount: PlayerController.Players.length,
                        itemBuilder: (_, indexs) {
                          return Wrap(
                            spacing: 0,
                            alignment: WrapAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(top: 7, bottom: 7),
                                  height: 70,
                                  width: 70,
                                  child: SvgPicture.asset(PlayerController.audios
                                      .singleWhere((element) =>
                                          element.id ==
                                          PlayerController
                                              .Players[indexs].players.playerId)
                                      .iconEdit)),
                              Container(
                                height: 70,
                                width: 180,
                                child: FlutterSlider(
                                  onDragCompleted:
                                      (handlerIndex, lowerValue, upperValue) {
                                    double val =
                                        double.parse(lowerValue.toString());
                                    PlayerController.audios
                                        .singleWhere((element) =>
                                            element.id ==
                                            PlayerController
                                                .Players[indexs].players.playerId)
                                        .volume = val;
                                  },
                                  onDragging:
                                      (handlerIndex, lowerValue, upperValue) {
                                    double val =
                                        double.parse(lowerValue.toString());
                                    print(val / 20);
                                    PlayerController.setVolume(
                                        PlayerController
                                            .Players[indexs].players.playerId,
                                        val / 40);
                                  },
                                  step: FlutterSliderStep(step: 15),
                                  handlerWidth: 15,
                                  handlerHeight: 28,
                                  jump: true,
                                  tooltip: FlutterSliderTooltip(
                                    disabled: true,

                                  ),
                                  trackBar: FlutterSliderTrackBar(
                                      activeTrackBar: BoxDecoration(
                                          color: Color(0xFFEBF5FB),
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      inactiveTrackBar: BoxDecoration(
                                          color: Color(0xFF47557E),
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  handler: FlutterSliderHandler(
                                    decoration: BoxDecoration(),
                                    child: Material(
                                      type: MaterialType.circle,
                                      color: Color(0xFF777BF1),
                                      elevation: 3,
                                      child: Container(
                                        width: 15,
                                        height: 20,
                                      ),
                                    ),
                                  ),
                                  max: 100,
                                  min: 0,
                                  values: [
                                    PlayerController.audios
                                        .singleWhere((element) =>
                                            element.id ==
                                            PlayerController
                                                .Players[indexs].players.playerId)
                                        .volume
                                  ],
                                ),
                              ),
                              Container(
                                  height: 70,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        PlayerController.audios
                                            .singleWhere((element) =>
                                                element.id ==
                                                PlayerController.Players[indexs]
                                                    .players.playerId)
                                            .visible = false;
                                        PlayerController.stop(PlayerController
                                            .Players[indexs].players.playerId);
                                        PlayerController.Players.removeAt(indexs);
                                      });
                                      CounterNotifier.decrement();
                                      if (CounterNotifier.EfektSayiKontrol.value == 0)
                                        Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.clear,
                                      color:Color(0xFFEBF5FB),
                                    ),
                                  ))
                            ],
                          );
                        },
                      ),
                    ),
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: PanelDialog.isTimer,
                      child: Countdown(
                        controller: PanelDialog.controller,
                        seconds: PanelDialog.seconds,
                        build: (_, double time) {
                          if (time == SettingsPage.lowVolume) {
                            FadeOut().fadeOut();
                          }
                          return Text(
                            "${_printDuration(time.toInt())}",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          );
                        },
                        interval: Duration(seconds: 1),
                        onFinished: () {

                          setState(() {
                            PanelDialog.isTimer = false;
                            IsplayNotifier.setTogglePlay();
                            PlayerController.pause();
                            PlayerController.Players.forEach((element) {
                              element.players.setVolume(element.volume / 20);
                            });
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Container(
                        height: 55,
                        width: double.maxFinite,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF777BF1)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(38)))),
                          onPressed: () {
                            PlayerController.stopall();
                            Navigator.pop(context);
                          },
                          child: Text("Clear All"),
                        ),
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                        valueListenable: IsplayNotifier.efectPlayerNotifier,
                        builder: (BuildContext context, value, Widget child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.3),
                                radius: 27,
                                child: CircleAvatar(
                                  backgroundColor: Color(0xFFEBF5FB),
                                  radius: 22,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.timer,
                                      color: Color(0xFF30313C),
                                    ),
                                    onPressed: _showTimerPickDialog,
                                    iconSize: 22,
                                    highlightColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.3),
                                radius: 35,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white.withOpacity(0.9),
                                  radius: 30,
                                  child: IconButton(
                                    icon: Icon(
                                      value ? Icons.pause : Icons.play_arrow,
                                      color: Color(0xFF30313C),
                                    ),
                                    onPressed: () {
                                      if (value) {
                                        IsplayNotifier.setTogglePlay();
                                        PanelDialog.controller.pause();
                                        PlayerController.pause();
                                        AudioManager.instance.updateNtf(false);
                                      } else {
                                        IsplayNotifier.setTogglePlay();
                                        PanelDialog.controller.resume();
                                        PlayerController.resume();
                                        AudioManager.instance.updateNtf(true);
                                      }
                                      setState(() {});
                                    },
                                    iconSize: 32,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white.withOpacity(0.3),
                                radius: 27,
                                child: CircleAvatar(
                                  backgroundColor: Color(0xFFEBF5FB),
                                  foregroundColor: Color(0xFFEBF5FB),
                                  radius: 22,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: Color(0xFF30313C),
                                    ),
                                    onPressed: () async{
                                      await _displayTextInputDialog(context);
                                    },
                                    highlightColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    iconSize: 22,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  _showTimerPickDialog() {
    showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              content: Container(
                height: 250,
                child: CupertinoTimerPicker(
                  initialTimerDuration: Duration(seconds: PanelDialog.seconds),
                  onTimerDurationChanged: (value) {
                    setState(() {
                      PanelDialog.seconds = value.inSeconds;
                    });
                  },
                  mode: CupertinoTimerPickerMode.hm,
                ),
              ),
              actions: <Widget>[
                CupertinoButton(
                  child: Text(PanelDialog.isTimer ? 'res'.tr() : 'cancel'.tr()),
                  onPressed: () {
                    if (PanelDialog.isTimer) {
                      PanelDialog.seconds = 0;
                      PanelDialog.isTimer = false;
                      setState(() {});
                    }
                    Navigator.pop(context);
                  },
                ),
                CupertinoButton(
                  child: Text(
                    'start',
                    style: TextStyle(color: Colors.red),
                  ).tr(),
                  onPressed: () {
                    setState(() {
                      if (IsplayNotifier.efectPlayerNotifier.value && PanelDialog.seconds >= 59) {
                        PanelDialog.isTimer = true;
                        PanelDialog.controller.restart();
                      } else if (PanelDialog.seconds >= 59) {
                        PanelDialog.isTimer = true;
                        PanelDialog.controller.restart();
                        PanelDialog.controller.pause();
                      } else if (PanelDialog.seconds == 0) PanelDialog.isTimer = false;
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
  Future<void> _displayTextInputDialog(context) async{
    if(user.isAnonymous&&Hive.box<Favorites>("favorites").length>2){
      return showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context, state) {
                  return CupertinoAlertDialog(
                    title: Text('Lütfen onaylı bir hesap açınız'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('tamam',),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                }
            );
          });
    }else{
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return StatefulBuilder(
                builder: (bc, state) {
                  return Container(
                    color: Color(0xFF08123A).withOpacity(0.8),
                    height: 280,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Name your favorites',style: TextStyle(color: Colors.white,fontSize: 20),),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:20.0),
                          child: TextField(
                            controller: _textFieldController,
                            decoration: InputDecoration(
                              errorText: favName ? "Enter at most 16 characters and at least 3 characters" : null,
                              errorStyle: TextStyle(color: Colors.redAccent),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Name",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:25.0),
                          child: Container(
                            height: 50,
                            width: double.maxFinite,
                            child: ElevatedButton(
                              child: Text('SAVE',),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(40.0))),
                              ),
                              onPressed: () {
                                state(() {
                                  if (_textFieldController.text.length < 3) {
                                    favName = true;
                                    setState(() {});
                                    return;
                                  } else if (_textFieldController.text.length > 14) {
                                    favName = true;
                                    setState(() {});
                                    return;
                                  }
                                  else {
                                    List<FavoritesModel> favoriler = [];
                                    PlayerController.audios.forEach((audios) {
                                      PlayerController.Players.forEach((players) {
                                        if (players.players.playerId == audios.id) {
                                          favoriler.add(FavoritesModel(
                                            volume: audios.volume,
                                            icon1: audios.iconFav,
                                            sesPath: audios.sesPath,
                                          ));
                                        }
                                      });
                                    });
                                    var uuid = Uuid();
                                    var v1 = uuid.v1();
                                    addFavorite(Favorites(favorites: favoriler, ID: v1, Name: _textFieldController.text));
                                    favName = false;
                                    ColorsPack.i.add(Random().nextInt(16));
                                    ColorsPack.j.add(Random().nextInt(11));
                                    Navigator.pop(bc);
                                    setState(() {});
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:25.0),
                          child: Container(
                            height: 50,
                            width: double.maxFinite,
                            child: ElevatedButton(
                              style:ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(40.0),
                                    )),

                                backgroundColor: MaterialStateProperty.all(Colors.indigoAccent),
                              ),
                              child: Text('CANCEL', style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(bc);
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
            );
          }
      );
    }
  }


  addFavorite(Favorites favori) {
    Box<Favorites> contactsBox = Hive.box<Favorites>("favorites");
    contactsBox.add(favori);
  }
}
