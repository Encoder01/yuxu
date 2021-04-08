import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mindfocus/Bloc/daily_mix/daily_mix_bloc.dart';
import 'package:mindfocus/Bloc/favplayer_bloc.dart';
import 'package:mindfocus/Bloc/quotes/quotes_bloc.dart';
import 'package:mindfocus/Bloc/recommend/recommend_bloc.dart';
import 'package:mindfocus/Model/favorites_model.dart';
import 'package:mindfocus/Services/authentication.dart';
import 'package:mindfocus/Widgets/SignPage/get_started.dart';
import 'package:mindfocus/Widgets/SignPage/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'Model/favorites.dart';
import 'Widgets/MainPage/main_page.dart';
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FacebookAudienceNetwork.init();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(FavoritesModelAdapter());
  await Hive.openBox<FavoritesModel>("favoritesModel");
  Hive.registerAdapter(FavoritesAdapter());
  await Hive.openBox<Favorites>("favorites");
  await Hive.openBox<List<String>>("hashtags");
  runApp(
    DevicePreview(
      enabled: false,
        builder: (_)=>EasyLocalization(
     child: MyApp(),
     startLocale: Locale('en', 'US'),
     supportedLocales: [
       Locale('en', 'US'),Locale('tr', 'TR'),Locale('ru', 'RU')],
     path: 'assets/translations',
     fallbackLocale: Locale('en', 'US'),
   ),
    ),
  );
}
class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        Provider<Authentication>(
          create: (_) => Authentication(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<Authentication>().authStateChanges,
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'MindFocus',
          navigatorObservers: <NavigatorObserver>[observer],
          home: AuthenticationWrapper()),
    );
  }
}
class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      if(firebaseUser.emailVerified||firebaseUser.isAnonymous){
        return MultiBlocProvider(providers: [
          BlocProvider(create: (context) => FavplayerBloc()),
          BlocProvider(create: (context) => RecommendBloc()),
          BlocProvider(create: (context) => DailyMixBloc()),
          BlocProvider(create: (context) => QuotesBloc()),
        ],
            child: MainPage());
      }
    }
    return SignIn();
  }
}