import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindfocus/Services/ColorsPack.dart';
import '../Buttons/efekt_btn.dart';

class MindPage extends StatefulWidget {
  @override
  _MindPageState createState() => _MindPageState();
}

class _MindPageState extends State<MindPage> {
  @override
  Widget build(BuildContext context) {
          return Stack(
            children: [
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: SvgPicture.asset(
                    "assets/susleme/dark/sus_4.svg",
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
                            ses: 'ses/Mind/piyano.m4a',
                            color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                            icon: 'assets/DarkButtons/Mind/v1/icon_1.svg',
                            icon2: 'assets/DarkButtons/Mind/v2/icon_1a.svg',
                            iconEdit: 'assets/EditButtons/cat4/icon_1.svg',
                            iconFav: 'assets/FavoriteButtons/cat4/icon_1.svg',
                            visible: false,
                          ),
                          EfektButton(
                            ses: 'ses/Mind/fulut.m4a',
                            color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                            icon: "assets/DarkButtons/Mind/v1/icon_2.svg",
                            icon2: 'assets/DarkButtons/Mind/v2/icon_2a.svg',
                            iconEdit: 'assets/EditButtons/cat4/icon_2.svg',
                            iconFav: 'assets/FavoriteButtons/cat4/icon_2.svg',
                            visible: false,
                          ),
                          EfektButton(
                            ses: 'ses/Mind/tibet_kasesi.m4a',
                            color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                            icon: "assets/DarkButtons/Mind/v1/icon_3.svg",
                            icon2: 'assets/DarkButtons/Mind/v2/icon_3a.svg',
                            iconEdit: 'assets/EditButtons/cat4/icon_3.svg',
                            iconFav: 'assets/FavoriteButtons/cat4/icon_3.svg',
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
                            icon: "assets/DarkButtons/Mind/v1/icon_4.svg",
                            icon2: 'assets/DarkButtons/Mind/v2/icon_4a.svg',
                            iconEdit: 'assets/EditButtons/cat4/icon_4.svg',
                            iconFav: 'assets/FavoriteButtons/cat4/icon_4.svg',
                            visible: false,
                          ),
                          EfektButton(
                            ses: 'ses/Mind/taslar.m4a',
                            color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                            icon: "assets/DarkButtons/Mind/v1/icon_5.svg",
                            icon2: 'assets/DarkButtons/Mind/v2/icon_5a.svg',
                            iconEdit: 'assets/EditButtons/cat4/icon_5.svg',
                            iconFav: 'assets/FavoriteButtons/cat4/icon_5.svg',
                            visible: false,
                          ),
                          EfektButton(
                            ses: 'ses/Mind/binaural5.m4a',
                            color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                            icon: "assets/DarkButtons/Mind/v1/icon_6.svg",
                            icon2: 'assets/DarkButtons/Mind/v2/icon_6a.svg',
                            iconEdit: 'assets/EditButtons/cat4/icon_6.svg',
                            iconFav: 'assets/FavoriteButtons/cat4/icon_6.svg',
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
                            icon: "assets/DarkButtons/Mind/v1/icon_7.svg",
                            icon2: 'assets/DarkButtons/Mind/v2/icon_7a.svg',
                            iconEdit: 'assets/EditButtons/cat4/icon_7.svg',
                            iconFav: 'assets/FavoriteButtons/cat4/icon_7.svg',
                            visible: false,
                          ),
                          EfektButton(
                            ses: 'ses/Mind/mavi_nokta.m4a',
                            color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                            icon: "assets/DarkButtons/Mind/v1/icon_8.svg",
                            icon2: 'assets/DarkButtons/Mind/v2/icon_8a.svg',
                            iconEdit: 'assets/EditButtons/cat4/icon_8.svg',
                            iconFav: 'assets/FavoriteButtons/cat4/icon_8.svg',
                            visible: false,
                          ),
                          EfektButton(
                            ses: 'ses/Mind/kirmizi_nokta.m4a',
                            color: [ColorsPack.mindsbg, ColorsPack.mindsthmb],
                            icon: "assets/DarkButtons/Mind/v1/icon_9.svg",
                            icon2: 'assets/DarkButtons/Mind/v2/icon_9a.svg',
                            iconEdit: 'assets/EditButtons/cat4/icon_9.svg',
                            iconFav: 'assets/FavoriteButtons/cat4/icon_9.svg',
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

