import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindfocus/Controller/theme.dart';
import 'package:mindfocus/Model/ColorsPack.dart';

import '../Buttons/efekt_btn.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
          return Stack(
            children: [
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: SvgPicture.asset(
                    "assets/susleme/${ notifier.darkTheme ? 'dark' : 'light'}/sus_2.svg",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EfektButton(
                          ses: 'ses/Weather/yumusak_yagmur.m4a',
                          color: [ColorsPack.havasbg, ColorsPack.havathmb],
                          icon:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v1/icon_1.svg',
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v2/icon_1a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Weather/gok_gurultulu_yagmur.m4a',
                          color: [ColorsPack.havasbg, ColorsPack.havathmb],
                          icon:
                          "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v1/icon_2.svg",
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v2/icon_2a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Weather/yagmur_cadir.m4a',
                          color: [ColorsPack.havasbg, ColorsPack.havathmb],
                          icon:
                          "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v1/icon_3.svg",
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v2/icon_3a.svg',
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
                          icon:
                          "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v1/icon_4.svg",
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v2/icon_4a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Weather/yildirim.m4a',
                          color: [ColorsPack.havasbg, ColorsPack.havathmb],
                          icon:
                          "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v1/icon_5.svg",
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v2/icon_5a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Weather/dalga.m4a',
                          color: [ColorsPack.havasbg, ColorsPack.havathmb],
                          icon:
                          "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v1/icon_6.svg",
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v2/icon_6a.svg',
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
                          icon:
                          "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v1/icon_7.svg",
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v2/icon_7a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Weather/ev_yagmur.m4a',
                          color: [ColorsPack.havasbg, ColorsPack.havathmb],
                          icon:
                          "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v1/icon_8.svg",
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v2/icon_8a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Weather/semsiye_yagmur.m4a',
                          color: [ColorsPack.havasbg, ColorsPack.havathmb],
                          icon:
                          "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v1/icon_9.svg",
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Weather/v2/icon_9a.svg',
                          visible: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
