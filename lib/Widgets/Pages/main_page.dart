import 'package:audio_manager/audio_manager.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindfocus/Model/effect_icons.dart';
import 'package:mindfocus/Services/Suggestion.dart';
import 'package:mindfocus/Widgets/Pages/effects_page.dart';
import 'package:mindfocus/Widgets/Pages/favorite_page.dart';
import 'package:mindfocus/Widgets/Pages/settings_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mindfocus/Widgets/Pages/suggestion_page.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}
class MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin {
  int _selectedPage = 0;
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
        data: Theme.of(context).copyWith(

            canvasColor: Color(0xFF040D1B),),
        child: Wrap(
          children: [
            Container(
              child: BottomNavigationBar(
                unselectedItemColor: Colors.white38,
               selectedItemColor: Colors.white.withOpacity(0.9),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    label: "Anasayfa"),
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
      _selectedPage = index;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
