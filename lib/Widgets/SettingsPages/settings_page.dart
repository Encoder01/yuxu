import 'dart:ui';
import 'package:audio_manager/audio_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindfocus/Controller/FavoriController.dart';
import 'package:mindfocus/Controller/PlayerController.dart';
import 'package:mindfocus/Controller/isplaynotifier.dart';
import 'package:mindfocus/Services/ColorsPack.dart';
import 'package:mindfocus/Services/authentication.dart';
import 'package:provider/provider.dart';


class SettingsPage extends StatefulWidget {
  static double lowVolume = 5;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsPack.settngs,
        title: Text(
          "setngs",
          style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.bold, fontSize: 25),
        ).tr(),
      ),
      body: Container(
        color: ColorsPack.settngslight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              context.read<Authentication>().getPrfoilpic(),
              width: 75,
              height: 75,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:20),
              child: Container(
                width: double.maxFinite,
                height: 55,
                child: ElevatedButton(
                  child: Text("lang".tr()),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)))
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (contexts) {
                          return CupertinoAlertDialog(
                              title: Text("langtitle").tr(),
                              content: Container(
                                  height: 200,
                                  width: 200,
                                  child: Scaffold(
                                      backgroundColor: Colors.transparent,
                                      body: Column(children: [
                                        ListTile(
                                          title: Text("eng").tr(),
                                          onTap: () {
                                            EasyLocalization.of(context).setLocale(Locale('en', 'US')) ;
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ListTile(
                                            title: Text("rus").tr(),
                                            onTap: () {
                                              EasyLocalization.of(context).setLocale(Locale('ru', 'RU'));
                                              Navigator.pop(context);
                                            }),
                                        ListTile(
                                            title: Text("turk").tr(),
                                            onTap: () {
                                              EasyLocalization.of(context).setLocale(Locale('tr', 'TR'));
                                              Navigator.pop(context);
                                            })
                                      ]))));
                        });
                  },
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (contexts) => CupertinoAlertDialog(
                      content: Text(
                        "darkMsg",
                        style: TextStyle(fontSize: 18),
                      ).tr(),
                      actions: [
                        CupertinoButton(
                            child: Text(
                              "no",
                            ).tr(),
                            onPressed: () => Navigator.pop(context)),
                        CupertinoButton(
                            child: Text(
                              "yes",
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            ).tr(),
                            onPressed: () async {
                              if (IsplayNotifier.IsEffect.value) {
                                PlayerController.stopall();
                                AudioManager.instance.toPause();
                              } else if (IsplayNotifier.Isfavori.value) {
                                FavoriController.playedFav.forEach((element) {
                                  element.isPlay = false;
                                  element.havePlay = false;
                                });
                                FavoriController.stopall();
                                IsplayNotifier.setFalseFavori();
                                AudioManager.instance.toPause();
                              }
                              Navigator.pop(context);
                              context.read<Authentication>().signOut();
                            }),
                      ],
                    ),
                  );
                },
                child: Text("Log Out " + context.read<Authentication>().getName()))
          ],
        ),
      ),
    );
  }
}
