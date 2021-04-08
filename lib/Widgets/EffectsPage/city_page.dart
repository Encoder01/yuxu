import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindfocus/Services/ColorsPack.dart';
import 'package:mindfocus/Widgets/Buttons/efekt_btn.dart';


class CityPage extends StatefulWidget {
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          children: [
            Align(
                alignment: FractionalOffset.bottomCenter,
                child: SvgPicture.asset(
                  "assets/susleme/dark/sus_3.svg",
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
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
                          ses: 'ses/City/tren.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: 'assets/DarkButtons/City/v1/icon_1.svg',
                          icon2: 'assets/DarkButtons/City/v2/icon_1a.svg',
                          iconEdit: 'assets/EditButtons/cat3/icon_1.svg',
                          iconFav: 'assets/FavoriteButtons/cat3/icon_1.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/City/tramva.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: "assets/DarkButtons/City/v1/icon_2.svg",
                          icon2: 'assets/DarkButtons/City/v2/icon_2a.svg',
                          iconEdit: 'assets/EditButtons/cat3/icon_2.svg',
                          iconFav: 'assets/FavoriteButtons/cat3/icon_2.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/City/ucak.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: "assets/DarkButtons/City/v1/icon_3.svg",
                          icon2: 'assets/DarkButtons/City/v2/icon_3a.svg',
                          iconEdit: 'assets/EditButtons/cat3/icon_3.svg',
                          iconFav: 'assets/FavoriteButtons/cat3/icon_3.svg',
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
                          icon: "assets/DarkButtons/City/v1/icon_4.svg",
                          icon2: 'assets/DarkButtons/City/v2/icon_4a.svg',
                          iconEdit: 'assets/EditButtons/cat3/icon_4.svg',
                          iconFav: 'assets/FavoriteButtons/cat3/icon_4.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/City/camasir_makinasi.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: "assets/DarkButtons/City/v1/icon_5.svg",
                          icon2: 'assets/DarkButtons/City/v2/icon_5a.svg',
                          iconEdit: 'assets/EditButtons/cat3/icon_5.svg',
                          iconFav: 'assets/FavoriteButtons/cat3/icon_5.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/City/klavye.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: "assets/DarkButtons/City/v1/icon_6.svg",
                          icon2: 'assets/DarkButtons/City/v2/icon_6a.svg',
                          iconEdit: 'assets/EditButtons/cat3/icon_6.svg',
                          iconFav: 'assets/FavoriteButtons/cat3/icon_6.svg',
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
                          icon: "assets/DarkButtons/City/v1/icon_7.svg",
                          icon2: 'assets/DarkButtons/City/v2/icon_7a.svg',
                          iconEdit: 'assets/EditButtons/cat3/icon_7.svg',
                          iconFav: 'assets/FavoriteButtons/cat3/icon_7.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/City/kafe.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: "assets/DarkButtons/City/v1/icon_8.svg",
                          icon2: 'assets/DarkButtons/City/v2/icon_8a.svg',
                          iconEdit: 'assets/EditButtons/cat3/icon_8.svg',
                          iconFav: 'assets/FavoriteButtons/cat3/icon_8.svg',
                          visible: false,
                        ),
                        EfektButton(
                          ses: 'ses/City/insanlar.m4a',
                          color: [ColorsPack.sehirsbg, ColorsPack.sehirthmb],
                          icon: "assets/DarkButtons/City/v1/icon_9.svg",
                          icon2: 'assets/DarkButtons/City/v2/icon_9a.svg',
                          iconEdit: 'assets/EditButtons/cat3/icon_9.svg',
                          iconFav: 'assets/FavoriteButtons/cat3/icon_9.svg',
                          visible: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
