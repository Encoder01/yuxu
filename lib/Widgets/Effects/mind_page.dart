import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_svg/svg.dart';
import 'package:mindfocus/Controller/theme.dart';
import 'package:mindfocus/Model/ColorsPack.dart';

import '../../main.dart';
import '../Buttons/efekt_btn.dart';

class MindPage extends StatefulWidget {
  @override
  _MindPageState createState() => _MindPageState();
}

class _MindPageState extends State<MindPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:ValueListenableBuilder(
          valueListenable: Hive.box(darkModeBox).listenable(),
          builder: (context, Box  box, child) {
            var darkMode = box.get('darkMode', defaultValue: false);
          return Stack(
            children: [
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: SvgPicture.asset(
                    "assets/susleme/${ darkMode? 'dark' : 'light'}/sus_4.svg",
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
                          ses: 'ses/Mind/piyano.m4a',
                          color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                          icon: 'assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v1/icon_1.svg',
                          icon2: 'assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v2/icon_1a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Mind/fulut.m4a',
                          color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                          icon: "assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v1/icon_2.svg",
                          icon2: 'assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v2/icon_2a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Mind/tibet_kasesi.m4a',
                          color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                          icon: "assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v1/icon_3.svg",
                          icon2: 'assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v2/icon_3a.svg',
                          visible: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EfektButton(
                          ses: 'ses/Mind/ruzgar_cani.m4a',
                          color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                          icon: "assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v1/icon_4.svg",
                          icon2: 'assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v2/icon_4a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Mind/taslar.m4a',
                          color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                          icon: "assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v1/icon_5.svg",
                          icon2: 'assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v2/icon_5a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Mind/binaural5.m4a',
                          color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                          icon: "assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v1/icon_6.svg",
                          icon2: 'assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v2/icon_6a.svg',
                          visible: false,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EfektButton(
                          ses: 'ses/Mind/yesil_nokta.m4a',
                          color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                          icon: "assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v1/icon_7.svg",
                          icon2: 'assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v2/icon_7a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Mind/mavi_nokta.m4a',
                          color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                          icon: "assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v1/icon_8.svg",
                          icon2: 'assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v2/icon_8a.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Mind/kirmizi_nokta.m4a',
                          color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                          icon: "assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v1/icon_9.svg",
                          icon2: 'assets/${ darkMode? 'Dark' : ''}Buttons/Mind/v2/icon_9a.svg',
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
