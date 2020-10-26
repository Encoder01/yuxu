
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindfocus/Controller/theme.dart';
import 'package:mindfocus/Services/Admob.dart';
import 'package:mindfocus/Widgets/Buttons/panel_btn.dart';
import 'package:mindfocus/Widgets/Pages/effects_page.dart';
import 'package:mindfocus/Widgets/Pages/settings_page.dart';
import 'package:easy_localization/easy_localization.dart';

class MainPage extends StatefulWidget {
  static bool isPlay = false;

  @override
  MainPageState createState() => MainPageState();
}
class MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin {
  int _selectedPage = 0;
  AdmobService admob = new AdmobService();

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    admob.bannerAd = admob.createBannerAd();
     // ..load();
      //..show(anchorOffset: 49);
    super.initState();
  }

  @override
  void dispose() {
   // admob.bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Offstage(
          offstage: _selectedPage != 0,
          child: EffectsPage(),
        ),
        Offstage(
          offstage: _selectedPage != 1,
          child: SettingsPage(),
        ),
        Container(height: MediaQuery.of(context).size.height*0.83,
            child: Center(child: Align(alignment: Alignment.bottomCenter,child: PanelButton())))
      ]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ThemeNotifier.Theme ? Color(0xFF051c21) : Color(0xFF082C33),
        selectedIconTheme: IconThemeData(color: Colors.white),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.adjust),
            label: "efekt".tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'setngs'.tr(),
          ),
        ],
        currentIndex: _selectedPage,
        onTap: _onTapped,
      ),
    );
  }

  void _onTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
