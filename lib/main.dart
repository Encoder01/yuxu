import 'package:easy_localization/easy_localization.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import 'Services/Admob.dart';
import 'Services/restart_widget.dart';
import 'Widgets/Pages/main_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const darkModeBox = 'darkModeTutorial';
bool darkmode = false;

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseAdMob.instance.initialize(appId: AdmobService().getAPPID(),analyticsEnabled:true,);

  await Hive.initFlutter();
  await Hive.openBox(darkModeBox);
  runApp(
    EasyLocalization(
      child: MyApp(),
      startLocale: Locale('en', 'US'),
      supportedLocales: [Locale('en', 'US'), Locale('tr', 'TR'), Locale('ru', 'RU')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RestartWidget(
        child: ValueListenableBuilder(
            valueListenable: Hive.box(darkModeBox).listenable(),
            builder: (context, box, widget) {
              var darkMode = box.get('darkMode', defaultValue: false);
              darkmode = darkMode;
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  title: 'MindFocus',
                  home: MainPage());
            }));
  }
}
