import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindfocus/Model/effect_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mindfocus/Widgets/DiscoveryPage/suggestion_page.dart';
import 'package:mindfocus/Widgets/EffectsPage/effects_page.dart';
import 'package:mindfocus/Widgets/FavoritePage/favorite_page.dart';
import 'package:mindfocus/Widgets/SettingsPages/settings_page.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin {
  int _selectedPage = 0;
  Color _color = Color(0xFF1C2031);
  @override
  void initState() {
    //  AdmobService().showBanner();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // AdmobService().removeBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Offstage(
          offstage: _selectedPage != 0,
          child: SuggestionPage(),
        ),
        Offstage(
          offstage: _selectedPage != 1,
          child: EffectsPage(),
        ),
        Offstage(
          offstage: _selectedPage != 2,
          child: FavoritePage(),
        ),
        Offstage(
          offstage: _selectedPage != 3,
          child: SettingsPage(),
        ),
        /*,*/
      ]),
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(canvasColor: _color),
        child: Wrap(
          children: [
            Container(
              child: BottomNavigationBar(
                unselectedItemColor: Color(0xFF515979),
                selectedItemColor: Colors.white.withOpacity(0.85),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Anasayfa"),
                  BottomNavigationBarItem(
                    icon: Icon(Effect.effect),
                    label: "efekt".tr(),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border),
                    label: "Favorite",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.more),
                    label: 'setngs'.tr(),
                  ),
                ],
                currentIndex: _selectedPage,
                onTap: _onTapped,
              ),
            ),
            Container(
              alignment: Alignment(0.5, 1),
              height: 50,
              child: FacebookBannerAd(
                placementId: "148593593386504_148593640053166",
                bannerSize: BannerSize.STANDARD,
                listener: (result, value) {
                  switch (result) {
                    case BannerAdResult.ERROR:
                      print("Error: $value");
                      return Container();
                      break;
                    case BannerAdResult.LOADED:
                      print("Loaded: $value");
                      break;
                    case BannerAdResult.CLICKED:
                      print("Clicked: $value");
                      break;
                    case BannerAdResult.LOGGING_IMPRESSION:
                      print("Logging Impression: $value");
                      break;
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTapped(int index) {
    setState(() {
      if (index == 0) {
        _color = Color(0xFF1C2031);
      } else if (index == 1) {
        _color = Color(0xFF02100F);
      } else if (index == 2) {
        _color = Color(0xFF060B26);
      } else if (index == 3) {
        _color = Color(0xFF060A26);
      }
      _selectedPage = index;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
