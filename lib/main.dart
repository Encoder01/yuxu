import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindfocus/Controller/countProv.dart';
import 'package:provider/provider.dart';
import 'Controller/theme.dart';
import 'Services/appbuild.dart';
import 'Services/restart_widget.dart';
import 'Widgets/Pages/main_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return AppBuilder(builder: (context) {
      return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => CounterNotifier(),
            ),
            ChangeNotifierProvider(
              create: (_) => ThemeNotifier(),
            ),
          ],
          child: RestartWidget(
            child: Consumer<ThemeNotifier>(
                builder: (context, ThemeNotifier notifier, child) {
                return GetMaterialApp(
                    navigatorObservers: <NavigatorObserver>[observer],
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    title: 'MindFocus',
                    home: MainPage());
              }
            ),
          ));
    });
  }
}
