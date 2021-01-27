import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:mindfocus/Controller/theme.dart';
import 'package:mindfocus/Model/ColorsPack.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../main.dart';
import '../Buttons/efekt_btn.dart';

class ForestPage extends StatefulWidget {
  @override
  _ForestPageState createState() => _ForestPageState();
}

class _ForestPageState extends State<ForestPage>  {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(darkModeBox).listenable(),
        builder: (context, Box  box, child) {
          var darkMode = box.get('darkMode', defaultValue: false);
        return Stack(
          children: [
            Align(
                alignment: FractionalOffset.bottomCenter,
                child: SvgPicture.asset(
                  "assets/susleme/${ darkMode ? 'dark' : 'light'}/sus_1.svg",
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
                        color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                        ses: 'ses/Nature/forest_forest.m4a',
                        icon: 'assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v1/icon_1.svg',
                        icon2:
                        'assets/${darkMode ? 'Dark' : ''}Buttons/Nature/v2/icon_1a.svg',
                        visible: false,
                      ),
                      EfektButton(
                        ses: 'ses/Nature/forest_wind.m4a',
                        color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                        icon: "assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v1/icon_2.svg",
                        icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v2/icon_2a.svg',
                        visible: false,
                      ),
                      EfektButton(
                        ses: 'ses/Nature/forest_leaves.m4a',
                        color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                        icon: "assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v1/icon_3.svg",
                        icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v2/icon_3a.svg',
                        visible: false,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EfektButton(
                        ses: 'ses/Nature/forest_birds.m4a',
                        color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                        icon: "assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v1/icon_4.svg",
                        icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v2/icon_4a.svg',
                        visible: false,
                      ),
                      EfektButton(
                        ses: 'ses/Nature/forest_river.m4a',
                        color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                        icon: "assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v1/icon_5.svg",
                        icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v2/icon_5a.svg',
                        visible: false,
                      ),
                      EfektButton(
                        ses: 'ses/Nature/forest_selale.m4a',
                        color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                        icon: "assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v1/icon_6.svg",
                        icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v2/icon_6a.svg',
                        visible: false,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EfektButton(
                        ses: 'ses/Nature/forest_wolf.m4a',
                        color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                        icon:  'assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v1/icon_7.svg',
                        icon2:  'assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v2/icon_7a.svg',
                        visible: false,
                      ),
                      EfektButton(
                        ses: 'ses/Nature/forest_frogs.m4a',
                        color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                        icon:  'assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v1/icon_8.svg',
                        icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v2/icon_8a.svg',
                        visible: false,
                      ),
                      EfektButton(
                        ses: 'ses/Nature/forest_fire.m4a',
                        color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                        icon: "assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v1/icon_9.svg",
                        icon2: 'assets/${ darkMode ? 'Dark' : ''}Buttons/Nature/v2/icon_9a.svg',
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
    );
  }


}
