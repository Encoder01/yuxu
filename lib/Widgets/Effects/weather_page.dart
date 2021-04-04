import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindfocus/Services/ColorsPack.dart';
import '../Buttons/efekt_btn.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: FractionalOffset.bottomCenter,
            child: SvgPicture.asset(
              "assets/susleme/dark/sus_2.svg",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            )),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EfektButton(
                      ses: 'ses/Weather/yumusak_yagmur.m4a',
                      color: [ColorsPack.havasbg, ColorsPack.havathmb],
                      icon: 'assets/DarkButtons/Weather/v1/icon_1.svg',
                      icon2: 'assets/DarkButtons/Weather/v2/icon_1a.svg',
                      iconEdit: 'assets/EditButtons/cat2/icon_1.svg',
                      iconFav: 'assets/FavoriteButtons/cat2/icon_1.svg',
                      visible: false,
                    ),
                    EfektButton(
                      ses: 'ses/Weather/gok_gurultulu_yagmur.m4a',
                      color: [ColorsPack.havasbg, ColorsPack.havathmb],
                      icon: "assets/DarkButtons/Weather/v1/icon_2.svg",
                      icon2: 'assets/DarkButtons/Weather/v2/icon_2a.svg',
                      iconEdit: 'assets/EditButtons/cat2/icon_2.svg',
                      iconFav: 'assets/FavoriteButtons/cat2/icon_2.svg',
                      visible: false,
                    ),
                    EfektButton(
                      ses: 'ses/Weather/yagmur_cadir.m4a',
                      color: [ColorsPack.havasbg, ColorsPack.havathmb],
                      icon: "assets/DarkButtons/Weather/v1/icon_3.svg",
                      icon2: 'assets/DarkButtons/Weather/v2/icon_3a.svg',
                      iconEdit: 'assets/EditButtons/cat2/icon_3.svg',
                      iconFav: 'assets/FavoriteButtons/cat2/icon_3.svg',
                      visible: false,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EfektButton(
                      ses: 'ses/Weather/guclu_yagmur.m4a',
                      color: [ColorsPack.havasbg, ColorsPack.havathmb],
                      icon: "assets/DarkButtons/Weather/v1/icon_4.svg",
                      icon2: 'assets/DarkButtons/Weather/v2/icon_4a.svg',
                      iconEdit: 'assets/EditButtons/cat2/icon_4.svg',
                      iconFav: 'assets/FavoriteButtons/cat2/icon_4.svg',
                      visible: false,
                    ),
                    EfektButton(
                      ses: 'ses/Weather/yildirim.m4a',
                      color: [ColorsPack.havasbg, ColorsPack.havathmb],
                      icon: "assets/DarkButtons/Weather/v1/icon_5.svg",
                      icon2: 'assets/DarkButtons/Weather/v2/icon_5a.svg',
                      iconEdit: 'assets/EditButtons/cat2/icon_5.svg',
                      iconFav: 'assets/FavoriteButtons/cat2/icon_5.svg',
                      visible: false,
                    ),
                    EfektButton(
                      ses: 'ses/Weather/dalga.m4a',
                      color: [ColorsPack.havasbg, ColorsPack.havathmb],
                      icon: "assets/DarkButtons/Weather/v1/icon_6.svg",
                      icon2: 'assets/DarkButtons/Weather/v2/icon_6a.svg',
                      iconEdit: 'assets/EditButtons/cat2/icon_6.svg',
                      iconFav: 'assets/FavoriteButtons/cat2/icon_6.svg',
                      visible: false,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EfektButton(
                      ses: 'ses/Weather/su_damlasi.m4a',
                      color: [ColorsPack.havasbg, ColorsPack.havathmb],
                      icon: "assets/DarkButtons/Weather/v1/icon_7.svg",
                      icon2: 'assets/DarkButtons/Weather/v2/icon_7a.svg',
                      iconEdit: 'assets/EditButtons/cat2/icon_7.svg',
                      iconFav: 'assets/FavoriteButtons/cat2/icon_7.svg',
                      visible: false,
                    ),
                    EfektButton(
                      ses: 'ses/Weather/ev_yagmur.m4a',
                      color: [ColorsPack.havasbg, ColorsPack.havathmb],
                      icon: "assets/DarkButtons/Weather/v1/icon_8.svg",
                      icon2: 'assets/DarkButtons/Weather/v2/icon_8a.svg',
                      iconEdit: 'assets/EditButtons/cat2/icon_8.svg',
                      iconFav: 'assets/FavoriteButtons/cat2/icon_8.svg',
                      visible: false,
                    ),
                    EfektButton(
                      ses: 'ses/Weather/semsiye_yagmur.m4a',
                      color: [ColorsPack.havasbg, ColorsPack.havathmb],
                      icon: "assets/DarkButtons/Weather/v1/icon_9.svg",
                      icon2: 'assets/DarkButtons/Weather/v2/icon_9a.svg',
                      iconEdit: 'assets/EditButtons/cat2/icon_9.svg',
                      iconFav: 'assets/FavoriteButtons/cat2/icon_9.svg',
                      visible: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
