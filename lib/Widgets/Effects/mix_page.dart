import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindfocus/Controller/theme.dart';
import 'package:mindfocus/Model/ColorsPack.dart';
import '../Buttons/efekt_btn.dart';

class MixPage extends StatefulWidget {
  @override
  _MixPageState createState() => _MixPageState();
}

class _MixPageState extends State<MixPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
          return Stack(
            children: [
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: SvgPicture.asset(
                    "assets/susleme/${ notifier.darkTheme ? 'dark' : 'light'}/sus_5.svg",
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
                          ses: 'ses/Mix/mix_sonar.m4a',
                          color: [ColorsPack.mixsbg, ColorsPack.mixsthmb],
                          icon: 'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v1/icon_1.svg',
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v2/icon_1a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Mix/balina_edit.mp3',
                          icon: "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v1/icon_2.svg",
                          color: [ColorsPack.mixsbg, ColorsPack.mixsthmb],
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v2/icon_2a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Mix/mix_kalp.m4a',
                          icon: "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v1/icon_3.svg",
                          color: [ColorsPack.mixsbg, ColorsPack.mixsthmb],
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v2/icon_3a.svg',
                          visible: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EfektButton(
                          ses: 'ses/Mix/mix_guvercin.m4a',
                          icon: "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v1/icon_4.svg",
                          color: [ColorsPack.mixsbg, ColorsPack.mixsthmb],
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v2/icon_4a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Mix/mix_balta.m4a',
                          icon: "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v1/icon_5.svg",
                          color: [ColorsPack.mixsbg, ColorsPack.mixsthmb],
                          icon2: 'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v2/icon_5a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Mix/mix_kuzgun.m4a',
                          icon: "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v1/icon_6.svg",
                          color: [ColorsPack.mixsbg, ColorsPack.mixsthmb],
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v2/icon_6a.svg',
                          visible: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EfektButton(
                          ses: 'ses/Mix/mix_sualti.m4a',
                          icon: "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v1/icon_7.svg",
                          color: [ColorsPack.mixsbg, ColorsPack.mixsthmb],
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v2/icon_7a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Mix/mix_sayfa.m4a',
                          icon: "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v1/icon_8.svg",
                          color: [ColorsPack.mixsbg, ColorsPack.mixsthmb],
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v2/icon_8a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Mix/mix_bicak.m4a',
                          icon: "assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v1/icon_9.svg",
                          color: [ColorsPack.mixsbg, ColorsPack.mixsthmb],
                          icon2:
                          'assets/${ notifier.darkTheme ? 'Dark' : ''}Buttons/Mix/v2/icon_9a.svg',
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
