import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as es;
import 'package:flutter_svg/svg.dart';
import 'package:mindfocus/Services/ColorsPack.dart';
import 'package:mindfocus/Widgets/Buttons/panel_btn.dart';
import 'package:mindfocus/Widgets/Effects/city_page.dart';
import 'package:mindfocus/Widgets/Effects/forest_page.dart';
import 'package:mindfocus/Widgets/Effects/mind_page.dart';
import 'package:mindfocus/Widgets/Effects/mix_page.dart';
import 'package:mindfocus/Widgets/Effects/weather_page.dart';

class EffectsPage extends StatefulWidget {
  @override
  _EffectsPageState createState() => _EffectsPageState();
}

class _EffectsPageState extends State<EffectsPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(text: "forest".tr()),
    Tab(text: 'weather'.tr()),
    Tab(text: 'city'.tr()),
    Tab(text: 'mind'.tr()),
    Tab(text: 'mix'.tr()),
  ];
  Color color;
  Color color2;
  String ustbarSvg = "assets/susleme/category_1.svg";

  @override
  void initState() {
    color = ColorsPack.doga;
    color2 = ColorsPack.dogalight;
    _tabController = TabController(
      length: 5,
      vsync: this,
    );
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        color = ColorsPack.doga;
        color2 = ColorsPack.dogalight;
        ustbarSvg = "assets/susleme/category_1.svg";
      }
      else if (_tabController.index == 1) {
        color = ColorsPack.hava;
        color2 = ColorsPack.havalight;
        ustbarSvg = "assets/susleme/category_2.svg";
      }
      else if (_tabController.index == 2) {
        color = ColorsPack.sehir;
        color2 = ColorsPack.sehirlight;
        ustbarSvg = "assets/susleme/category_3.svg";
      }
      else if (_tabController.index == 3) {
        color = ColorsPack.mind;
        color2 = ColorsPack.mindlight;
        ustbarSvg = "assets/susleme/category_4.svg";
      }
      else if (_tabController.index == 4) {
        color = ColorsPack.mix;
        color2 = ColorsPack.mixlight;
        ustbarSvg = "assets/susleme/category_5.svg";
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                    width: 500,
                    child: SvgPicture.asset(
                      ustbarSvg,
                      height: 210,
                      fit: BoxFit.fitWidth,
                    )),
              ),
              Positioned.fill(
                top: 195,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: color2,
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                            color: color,
                            borderRadius:
                                BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))),
                        labelColor: ColorsPack.label,
                        unselectedLabelColor: ColorsPack.label2,
                        indicatorColor: Colors.white.withOpacity(0),
                        controller: _tabController,
                        isScrollable: true,
                        tabs: [
                          Tab(text: "forest".tr()),
                          Tab(text: 'weather'.tr()),
                          Tab(text: 'city'.tr()),
                          Tab(text: 'mind'.tr()),
                          Tab(text: 'mix'.tr()),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(controller: _tabController,physics: NeverScrollableScrollPhysics(), children: [
                        Container(color: ColorsPack.dogalight, child: ForestPage()),
                        Container(color: ColorsPack.havalight, child: WeatherPage()),
                        Container(color: ColorsPack.sehirlight, child: CityPage()),
                        Container(color: ColorsPack.mindlight, child: MindPage()),
                        Container(color: ColorsPack.mixlight, child: MixPage()),
                      ]),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        width: double.maxFinite,
                        height: 55,
                        child: Center(child: PanelButton(color))),
                  )),
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
