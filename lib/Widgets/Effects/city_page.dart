import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindfocus/Model/ColorsPack.dart';

import '../../main.dart';
import '../Buttons/efekt_btn.dart';

class CityPage extends StatefulWidget {
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
          valueListenable: Hive.box(darkModeBox).listenable(),
          builder: (context, Box  box, child) {
            var darkMode = box.get('darkMode', defaultValue: false);
          return Stack(
            children: [
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: SvgPicture.asset(
                    "assets/susleme/${ darkMode ? 'dark' : 'light'}/sus_3.svg",
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
                          ses: 'ses/City/tren.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: 'assets/${ darkMode ? 'Dark' : ''}Buttons/City/v1/icon_1.svg',
                          icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/City/v2/icon_1a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/City/tramva.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: "assets/${ darkMode ? 'Dark' : ''}Buttons/City/v1/icon_2.svg",
                          icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/City/v2/icon_2a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/City/ucak.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: "assets/${ darkMode ? 'Dark' : ''}Buttons/City/v1/icon_3.svg",
                          icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/City/v2/icon_3a.svg',
                          visible: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EfektButton(
                          ses: 'ses/City/araba.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: "assets/${ darkMode ? 'Dark' : ''}Buttons/City/v1/icon_4.svg",
                          icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/City/v2/icon_4a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/City/camasir_makinasi.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: "assets/${ darkMode ? 'Dark' : ''}Buttons/City/v1/icon_5.svg",
                          icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/City/v2/icon_5a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/City/klavye.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: "assets/${ darkMode ? 'Dark' : ''}Buttons/City/v1/icon_6.svg",
                          icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/City/v2/icon_6a.svg',
                          visible: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EfektButton(
                          ses: 'ses/City/fan.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: "assets/${ darkMode ? 'Dark' : ''}Buttons/City/v1/icon_7.svg",
                          icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/City/v2/icon_7a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/City/kafe.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: "assets/${ darkMode ? 'Dark' : ''}Buttons/City/v1/icon_8.svg",
                          icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/City/v2/icon_8a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/City/insanlar.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: "assets/${ darkMode ? 'Dark' : ''}Buttons/City/v1/icon_9.svg",
                          icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/City/v2/icon_9a.svg',
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
