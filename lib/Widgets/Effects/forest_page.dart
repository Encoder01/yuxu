import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindfocus/Services/ColorsPack.dart';
import '../Buttons/efekt_btn.dart';

class ForestPage extends StatefulWidget {
  @override
  _ForestPageState createState() => _ForestPageState();
}

class _ForestPageState extends State<ForestPage>  {
  @override
  Widget build(BuildContext context) {
        return Stack(
          children: [
            Align(
                alignment: FractionalOffset.bottomCenter,
                child: SvgPicture.asset(
                  "assets/susleme/dark/sus_1.svg",
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
                          color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                          ses: 'ses/Nature/forest_forest.m4a',
                          icon: 'assets/DarkButtons/Nature/v1/icon_1.svg',
                          icon2: 'assets/DarkButtons/Nature/v2/icon_1a.svg',
                          iconEdit: 'assets/EditButtons/cat1/icon_1.svg',
                          iconFav: 'assets/FavoriteButtons/cat1/icon_1.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Nature/forest_wind.m4a',
                          color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                          icon: "assets/DarkButtons/Nature/v1/icon_2.svg",
                          icon2: 'assets/DarkButtons/Nature/v2/icon_2a.svg',
                          iconEdit: 'assets/EditButtons/cat1/icon_2.svg',
                          iconFav: 'assets/FavoriteButtons/cat1/icon_2.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Nature/forest_leaves.m4a',
                          color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                          icon: "assets/DarkButtons/Nature/v1/icon_3.svg",
                          icon2: 'assets/DarkButtons/Nature/v2/icon_3a.svg',
                          iconEdit: 'assets/EditButtons/cat1/icon_3.svg',
                          iconFav: 'assets/FavoriteButtons/cat1/icon_3.svg',
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
                          icon: "assets/DarkButtons/Nature/v1/icon_4.svg",
                          icon2: 'assets/DarkButtons/Nature/v2/icon_4a.svg',
                          iconEdit: 'assets/EditButtons/cat1/icon_4.svg',
                          iconFav: 'assets/FavoriteButtons/cat1/icon_4.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Nature/forest_river.m4a',
                          color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                          icon: "assets/DarkButtons/Nature/v1/icon_5.svg",
                          icon2: 'assets/DarkButtons/Nature/v2/icon_5a.svg',
                          iconEdit: 'assets/EditButtons/cat1/icon_5.svg',
                          iconFav: 'assets/FavoriteButtons/cat1/icon_5.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Nature/forest_selale.m4a',
                          color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                          icon: "assets/DarkButtons/Nature/v1/icon_6.svg",
                          icon2: 'assets/DarkButtons/Nature/v2/icon_6a.svg',
                          iconEdit: 'assets/EditButtons/cat1/icon_6.svg',
                          iconFav: 'assets/FavoriteButtons/cat1/icon_6.svg',
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
                          icon:  'assets/DarkButtons/Nature/v1/icon_7.svg',
                          icon2:  'assets/DarkButtons/Nature/v2/icon_7a.svg',
                          iconEdit: 'assets/EditButtons/cat1/icon_7.svg',
                          iconFav: 'assets/FavoriteButtons/cat1/icon_7.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Nature/forest_frogs.m4a',
                          color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                          icon:  'assets/DarkButtons/Nature/v1/icon_8.svg',
                          icon2: 'assets/DarkButtons/Nature/v2/icon_8a.svg',
                          iconEdit: 'assets/EditButtons/cat1/icon_8.svg',
                          iconFav: 'assets/FavoriteButtons/cat1/icon_8.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/Nature/forest_fire.m4a',
                          color: [ColorsPack.dogasbg, ColorsPack.dogathmb],
                          icon: "assets/DarkButtons/Nature/v1/icon_9.svg",
                          icon2: 'assets/DarkButtons/Nature/v2/icon_9a.svg',
                          iconEdit: 'assets/EditButtons/cat1/icon_9.svg',
                          iconFav: 'assets/FavoriteButtons/cat1/icon_9.svg',
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
