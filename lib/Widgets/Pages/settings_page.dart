import 'package:audio_manager/audio_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindfocus/Controller/countProv.dart';
import 'package:mindfocus/Controller/theme.dart';
import 'package:mindfocus/Model/ColorsPack.dart';
import 'package:mindfocus/Controller/PlayerController.dart';
import 'package:mindfocus/Services/appbuild.dart';
import 'package:mindfocus/Services/restart_widget.dart';
import 'package:mindfocus/Widgets/Pages/main_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static double lowVolume = 5;
  static bool theme = false;
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  int selectedRadio = 0;

  @override
  void initState() {
    prefs.then((value) {
      selectedRadio = value.getInt("radio") ?? 0;
      if (selectedRadio == 0)
        SettingsPage.lowVolume = 5;
      else if (selectedRadio == 1)
        SettingsPage.lowVolume = 10;
      else if (selectedRadio == 2)
        SettingsPage.lowVolume = 15;
      else if (selectedRadio == 3) SettingsPage.lowVolume = 20;
    });
    prefs.then((value) => SettingsPage.theme = value.getBool("dark") ?? false);
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FlatButton(
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.deepPurpleAccent,
                  onPressed: () => showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: Text("sectitle").tr(),
                          content: Container(
                            height: 250,
                            child: Scaffold(
                              backgroundColor: Colors.transparent,
                              body: StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List<Widget>.generate(4, (int index) {
                                      return ListTile(
                                        title:
                                            Text((5 * (index + 1)).toString() + " " + "sec".tr()),
                                        trailing: Radio<int>(
                                          value: index,
                                          groupValue: selectedRadio,
                                          onChanged: (int value) {
                                            prefs.then((prefs) => prefs.setInt('radio', value));
                                            setState(() => selectedRadio = value);
                                            if (selectedRadio == 0)
                                              SettingsPage.lowVolume = 5;
                                            else if (selectedRadio == 1)
                                              SettingsPage.lowVolume = 10;
                                            else if (selectedRadio == 2)
                                              SettingsPage.lowVolume = 15;
                                            else if (selectedRadio == 3)
                                              SettingsPage.lowVolume = 20;
                                          },
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                  child: ListTile(
                    title: Text(
                      "reduce",
                      style: TextStyle(color: Colors.white),
                    ).tr(),
                    trailing: Icon(
                      Icons.volume_up_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Consumer<ThemeNotifier>(
                  builder: (context, ThemeNotifier notifier, child) {
                    return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FlatButton(
                        shape:
                        new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        color: Colors.deepPurpleAccent,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (contexts) => CupertinoAlertDialog(
                              content: Text("darkMsg",style: TextStyle(fontSize: 18),).tr(),
                              actions: [
                                CupertinoButton(
                                    child: Text(
                                      "no",
                                    ).tr(),
                                    onPressed: () => Navigator.pop(context)),
                                Consumer<CounterNotifier>(
                                    builder: (context, CounterNotifier count, child) {
                                    return CupertinoButton(
                                            child: Text(
                                              "yes",
                                              style: TextStyle(fontSize: 16,color: Colors.red),
                                            ).tr(),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              PlayerController.stopall();
                                              count.sifirla();
                                              AudioManager.instance.toPause();
                                              notifier.toggleTheme();
                                              RestartWidget.restartApp(context);
                                            });
                                  }
                                ),
                              ],
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(
                            ThemeNotifier.Theme? 'dark' :
                            'day',
                            style: TextStyle(color: Colors.white),
                          ).tr(),
                          trailing: Icon(
                            ThemeNotifier.Theme ?Icons.nightlight_round:
                            Icons.wb_sunny,
                            color: Colors.white,
                          ),
                        )),
                  );
                }
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FlatButton(
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.deepPurpleAccent,
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
                                body: Column(
                                  children: [
                                    ListTile(
                                      title: Text("eng").tr(),
                                      onTap: () {
                                        EasyLocalization.of(context).locale = Locale('en', 'US');
                                        if(MainPage.isPlay)Future.delayed(Duration(seconds: 1)).then((value) => updateNotf());
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                        title: Text("rus").tr(),
                                        onTap: () {
                                          EasyLocalization.of(context).locale = Locale('ru', 'RU');
                                          if(MainPage.isPlay)Future.delayed(Duration(seconds: 1)).then((value) => updateNotf());
                                          Navigator.pop(context);
                                        }),
                                    ListTile(
                                        title: Text("turk").tr(),
                                        onTap: () {
                                          EasyLocalization.of(context).locale = Locale('tr', 'TR');
                                          if(MainPage.isPlay)Future.delayed(Duration(seconds: 1)).then((value) => updateNotf());
                                          Navigator.pop(context);
                                        }),
                                  ],
                                )),
                          ),
                        );
                      },
                    );
                  },
                  child: ListTile(
                    title: Text(
                      "lang",
                      style: TextStyle(color: Colors.white),
                    ).tr(),
                    trailing: Icon(ThemeNotifier.Theme ? Icons.language : Icons.language,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  updateNotf(){
    AudioManager.instance.start("assets/ses/City/araba.m4a", "Mindfocus:Relax",desc:"notif".tr(),cover:"assets/logo.png");
  }
}
