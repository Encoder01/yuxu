import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mindfocus/Model/ColorsPack.dart';
import 'package:mindfocus/Widgets/Effects/city_page.dart';
import 'package:mindfocus/Widgets/Effects/forest_page.dart';
import 'package:mindfocus/Widgets/Effects/mind_page.dart';
import 'package:mindfocus/Widgets/Effects/mix_page.dart';
import 'package:mindfocus/Widgets/Effects/weather_page.dart';

class EffectsPage extends StatefulWidget {
  @override
  _EffectsPageState createState() => _EffectsPageState();
}

class _EffectsPageState extends State<EffectsPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(text: "forest".tr()),
    Tab(text: 'weather'.tr()),
    Tab(text: 'city'.tr()),
    Tab(text: 'mind'.tr()),
    Tab(text: 'mix'.tr()),
  ];
  Color color;

  @override
  void initState() {
    color = ColorsPack.doga;
    _tabController = TabController(length: 5, vsync: this, );

    _tabController.addListener(() {
      if (_tabController.index == 0)
        color = ColorsPack.doga;
      else if (_tabController.index == 1)
        color = ColorsPack.hava;
      else if (_tabController.index == 2)
        color = ColorsPack.sehir;
      else if (_tabController.index == 3)
        color = ColorsPack.mind;
      else if (_tabController.index == 4) color = ColorsPack.mix;
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

        length: 5,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            titleSpacing: 5,
            title: Text(
              "efekt".tr(),
              style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.bold, fontSize: 25),
            ),
            backgroundColor: color,
            bottom: TabBar(

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
          body: TabBarView(controller: _tabController, children: [
            Container(color: ColorsPack.dogalight, child: ForestPage()),
            Container(color: ColorsPack.havalight, child: WeatherPage()),
            Container(color: ColorsPack.sehirlight, child: CityPage()),
            Container(color: ColorsPack.mindlight, child: MindPage()),
            Container(color: ColorsPack.mixlight, child: MixPage()),
          ]),
        ));
  }
  @override
  void dispose() {
    print("dispose");
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
