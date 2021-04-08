import 'dart:math';

import 'package:audio_manager/audio_manager.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindfocus/Bloc/daily_mix/daily_mix_bloc.dart';
import 'package:mindfocus/Bloc/quotes/quotes_bloc.dart';
import 'package:mindfocus/Bloc/recommend/recommend_bloc.dart';
import 'package:mindfocus/Controller/FavoriController.dart';
import 'package:mindfocus/Controller/PlayerController.dart';
import 'package:mindfocus/Controller/SuggestController.dart';
import 'package:mindfocus/Controller/isplaynotifier.dart';
import 'package:mindfocus/Model/audio_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mindfocus/Model/dailymix_model.dart';
import 'package:mindfocus/Model/playedFav.dart';
import 'package:mindfocus/Services/authentication.dart';

class SuggestionPage extends StatefulWidget {
  static bool currentPlay = false;

  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  ScrollController _scrollControllers;
  ValueNotifier<double> containerHeig=ValueNotifier(WidgetsBinding.instance.window.physicalSize.width* 35 / 100);
  double _scrollPosition=0;

  @override
  void initState() {
    BlocProvider.of<RecommendBloc>(context).add(FetchRecommendEvent());
    BlocProvider.of<DailyMixBloc>(context).add(FetchDailyMixEvent());
    BlocProvider.of<QuotesBloc>(context).add(FetchQuotesEvent());
    _scrollControllers = ScrollController();
    _scrollControllers.addListener(() {
      _scrollPosition=_scrollControllers.position.pixels;
      if(!_scrollPosition.isNegative){
        if(_scrollPosition<=(WidgetsBinding.instance.window.physicalSize.width* 35 / 100)-1){
          containerHeig.value=(WidgetsBinding.instance.window.physicalSize.width* 35 / 100)-_scrollPosition*60/100;
        }
      }
    });
    super.initState();
  }

  String currentID = "";
  Future refresh() async {
    BlocProvider.of<RecommendBloc>(context).add(FetchRecommendEvent());
    BlocProvider.of<DailyMixBloc>(context).add(FetchDailyMixEvent());
    BlocProvider.of<QuotesBloc>(context).add(FetchQuotesEvent());
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131624),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          controller: _scrollControllers,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  ValueListenableBuilder<double>(
                      valueListenable: containerHeig,
                      builder: (context,  value, _) {
                      return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: value ,
                          child: SvgPicture.asset(
                            "assets/susleme/homepagev1.svg",
                            height: 300,
                            fit: BoxFit.cover,
                          ));
                    }
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black.withOpacity(0.7), Colors.transparent])),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Good Morning ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "sfproBold"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  context.read<Authentication>().getName(),
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 28, fontFamily: "sfproBold"),
                                ),
                              ),
                            ],
                          ),
                          BlocBuilder<QuotesBloc, QuotesState>(builder: (context, event) {
                            if (event is QuotesLoadedState) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  event.quotes[Random().nextInt(event.quotes.length)],
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 15,fontFamily: "sfproBold"),
                                ),
                              );
                            } else {
                              return Text("");
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ValueListenableBuilder<bool>(
                  valueListenable: IsplayNotifier.PlayerSuggs,
                  builder: (context, value, child) {
                    SuggstionController.playedSuggs = [];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:15.0,top:12,bottom: 12),
                          child: Text(
                            "My Daily Mixs",
                            style: TextStyle(color: Colors.white,fontSize: 24,fontFamily: "sfproBold"),
                          ),
                        ),
                        BlocBuilder<DailyMixBloc, DailyMixState>(builder: (context, event) {
                          if (event is DailyMixLoadedState) {
                            print(event.daily.toString());
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: StaggeredGridView.countBuilder(
                                crossAxisCount: 4,
                                shrinkWrap: true,
                                staggeredTileBuilder: (int index) =>
                                    new StaggeredTile.count(index == 2 ? 4 : 2, index == 2 ? 1.2 : 2),
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 4.0,
                                physics: NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 8.0),
                                itemCount: event.daily.length,
                                itemBuilder: (BuildContext context, int index) {
                                  DailyMixModel currentMusic = event.daily[index];
                                  if (IsplayNotifier.IsSuggs.value) {
                                    if (currentID == currentMusic.id) {
                                      SuggstionController.playedSuggs.add(Played(
                                          id: currentMusic.id,
                                          isPlay: SuggestionPage.currentPlay,
                                          havePlay: SuggestionPage.currentPlay));
                                    } else {
                                      SuggstionController.playedSuggs
                                          .add(Played(id: currentMusic.id, isPlay: false, havePlay: false));
                                    }
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: new Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomLeft,
                                                end:Alignment.topRight,
                                                colors: [
                                                  index==0?Color(0xFF13DEA0):index==1?Color(0xFFFC67A7):Color(0xFFFFD541),
                                                  index==0?Color(0xFF06B782):index==1?Color(0xFFF6815B):Color(0xFFF0B31A),
                                                ]
                                            ),
                                            image: DecorationImage(
                                                image: AssetImage("assets/susleme/dalga.png"),
                                                alignment: Alignment.bottomCenter,
                                                ),
                                            borderRadius: BorderRadius.circular(16)),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top: index == 2 ? 30 : 70,
                                                left: index == 2 ? 20 : 12,
                                                child: Container(
                                                    width: 180,
                                                    child: Text(
                                                      currentMusic.name,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: "sfproBold",
                                                          color: Colors.white),
                                                    ))),
                                            Positioned(
                                                top: index == 2 ? 60 : 92,
                                                left: index == 2 ? 20 : 12,
                                                child: Container(
                                                  width: 110,
                                                  child: Wrap(
                                                      crossAxisAlignment: WrapCrossAlignment.center,
                                                      children: currentMusic.sounds.icons
                                                          .map((e) => Padding(
                                                                padding: const EdgeInsets.all(3.0),
                                                                child: Container(
                                                                    height: 22,
                                                                    width: 22,
                                                                    child: SvgPicture.asset(
                                                                      e,
                                                                      fit: BoxFit.scaleDown,
                                                                      color: Colors.white,
                                                                    )),
                                                              ))
                                                          .toList()),
                                                )),
                                            Positioned(
                                                bottom: index == 2 ? 30 : 10,
                                                right: index == 2 ? 18 : 10,
                                                child: CircleAvatar(
                                                  backgroundColor: Color(0xFFEBF5FB),
                                                  radius: 17,
                                                  child: IconButton(
                                                      iconSize: 19,
                                                      onPressed: () {
                                                        if (IsplayNotifier.IsEffect.value ||
                                                            IsplayNotifier.Isfavori.value) {
                                                          shwDialog(currentMusic);
                                                          return;
                                                        }
                                                        SuggstionController.playedSuggs.forEach((element) {
                                                          print(element.id);
                                                          print("current ID:" + currentID);
                                                          if (element.id != currentID) {
                                                            element.isPlay = false;
                                                            element.havePlay = false;
                                                          }
                                                        });
                                                        if (SuggstionController.getHaveplay(currentMusic.id)) {
                                                          if (SuggstionController.getIsplay(currentMusic.id)) {
                                                            SuggstionController.setIsplay(currentMusic.id, false);
                                                            SuggstionController.pause();
                                                            //  IsplayNotifier.setToggleSugg();
                                                            SuggestionPage.currentPlay = false;
                                                            AudioManager.instance.updateNtf(false);
                                                          } else {
                                                            SuggstionController.setIsplay(currentMusic.id, true);
                                                            SuggstionController.resume();
                                                            // IsplayNotifier.setToggleSugg();
                                                            SuggestionPage.currentPlay = true;
                                                            AudioManager.instance.updateNtf(true);
                                                          }
                                                        } else {
                                                          SuggstionController.setIsplay(currentMusic.id, true);
                                                          SuggstionController.setHaveplay(currentMusic.id, true);
                                                          SuggestionPage.currentPlay = true;
                                                          openMusic(currentMusic);
                                                          // IsplayNotifier.setToggleSugg();
                                                        }
                                                        IsplayNotifier.setToggleSugg();
                                                        currentID = currentMusic.id;
                                                      },
                                                      icon: Icon(SuggstionController.getIsplay(currentMusic.id)
                                                          ? Icons.pause
                                                          : Icons.play_arrow_rounded)),
                                                )),
                                          ],
                                        )),
                                  );
                                },
                              ),
                            );
                          } else if (event is RecLoadingState) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                        Padding(
                          padding: const EdgeInsets.only(left:15.0,top:12,bottom: 12),
                          child: Text(
                            "Recomended for you",
                            style: TextStyle(color: Colors.white,fontSize: 24,fontFamily: "sfproBold"),
                          ),
                        ),
                        BlocBuilder<DailyMixBloc, DailyMixState>(builder: (context, event) {
                          if (event is DailyMixLoadedState) {
                            return  SizedBox(
                              height: 160,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child:  ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: List.generate( event.daily.length, (index) {
                                      DailyMixModel currentMusic = event.daily[index];
                                      if (IsplayNotifier.IsSuggs.value) {
                                        if (currentID == currentMusic.id) {
                                          SuggstionController.playedSuggs.add(Played(
                                              id: currentMusic.id,
                                              isPlay: SuggestionPage.currentPlay,
                                              havePlay: SuggestionPage.currentPlay));
                                        } else {
                                          SuggstionController.playedSuggs
                                              .add(Played(id: currentMusic.id, isPlay: false, havePlay: false));
                                        }
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            width: 160,
                                            decoration: BoxDecoration(
                                                color: Color(event.daily[index].color),
                                                borderRadius: BorderRadius.circular(16)),
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                    top:  60,
                                                    left:  12,
                                                    child: Container(
                                                        width: 180,
                                                        child: Text(
                                                          currentMusic.name,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: "sfproBold",
                                                              color: Colors.white),
                                                        ))),
                                                Positioned(
                                                    top: 82,
                                                    left: 12,
                                                    child: Container(
                                                      width: 110,
                                                      child: Wrap(
                                                          crossAxisAlignment: WrapCrossAlignment.center,
                                                          children: currentMusic.sounds.icons
                                                              .map((e) => Padding(
                                                            padding: const EdgeInsets.all(3.0),
                                                            child: Container(
                                                                height: 22,
                                                                width: 22,
                                                                child: SvgPicture.asset(
                                                                  e,
                                                                  fit: BoxFit.scaleDown,
                                                                  color: Colors.white,
                                                                )),
                                                          ))
                                                              .toList()),
                                                    )),
                                                Positioned(
                                                    bottom:  10,
                                                    right: 10,
                                                    child: CircleAvatar(
                                                      backgroundColor: Color(0xFFEBF5FB),
                                                      radius: 17,
                                                      child: IconButton(
                                                          iconSize: 19,
                                                          onPressed: () {
                                                            if (IsplayNotifier.IsEffect.value ||
                                                                IsplayNotifier.Isfavori.value) {
                                                              shwDialog(currentMusic);
                                                              return;
                                                            }
                                                            SuggstionController.playedSuggs.forEach((element) {
                                                              print(element.id);
                                                              print("current ID:" + currentID);
                                                              if (element.id != currentID) {
                                                                element.isPlay = false;
                                                                element.havePlay = false;
                                                              }
                                                            });
                                                            if (SuggstionController.getHaveplay(currentMusic.id)) {
                                                              if (SuggstionController.getIsplay(currentMusic.id)) {
                                                                SuggstionController.setIsplay(
                                                                    currentMusic.id, false);
                                                                SuggstionController.pause();
                                                                //  IsplayNotifier.setToggleSugg();
                                                                SuggestionPage.currentPlay = false;
                                                                AudioManager.instance.updateNtf(false);
                                                              } else {
                                                                SuggstionController.setIsplay(
                                                                    currentMusic.id, true);
                                                                SuggstionController.resume();
                                                                // IsplayNotifier.setToggleSugg();
                                                                SuggestionPage.currentPlay = true;
                                                                AudioManager.instance.updateNtf(true);
                                                              }
                                                            } else {
                                                              SuggstionController.setIsplay(currentMusic.id, true);
                                                              SuggstionController.setHaveplay(
                                                                  currentMusic.id, true);
                                                              SuggestionPage.currentPlay = true;
                                                              openMusic(currentMusic);
                                                              // IsplayNotifier.setToggleSugg();
                                                            }
                                                            IsplayNotifier.setToggleSugg();
                                                            currentID = currentMusic.id;
                                                          },
                                                          icon: Icon(SuggstionController.getIsplay(currentMusic.id)
                                                              ? Icons.pause
                                                              : Icons.play_arrow_rounded)),
                                                    )),
                                              ],
                                            )
                                        ),
                                      );
                                    })),
                              ),
                            );
                          } else {
                            return Container(color: Colors.green,);
                          }
                        }),
                        Padding(
                          padding: const EdgeInsets.only(left:15.0,top:12,bottom: 12),
                          child: Text(
                            "Recently Added",
                            style: TextStyle(color: Colors.white,fontSize: 24,fontFamily: "sfproBold"),
                          ),
                        ),
                        BlocBuilder<DailyMixBloc, DailyMixState>(builder: (context, event) {
                          if (event is DailyMixLoadedState) {
                            print(event.daily.toString());
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: StaggeredGridView.countBuilder(
                                crossAxisCount: 4,
                                shrinkWrap: true,
                                staggeredTileBuilder: (int index) =>
                                new StaggeredTile.count( 2, 2),
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 4.0,
                                physics: NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 8.0),
                                itemCount: 6,
                                itemBuilder: (BuildContext context, int index) {
                                  DailyMixModel currentMusic = event.daily[Random().nextInt(3)];
                                  if (IsplayNotifier.IsSuggs.value) {
                                    if (currentID == currentMusic.id) {
                                      SuggstionController.playedSuggs.add(Played(
                                          id: currentMusic.id,
                                          isPlay: SuggestionPage.currentPlay,
                                          havePlay: SuggestionPage.currentPlay));
                                    } else {
                                      SuggstionController.playedSuggs
                                          .add(Played(id: currentMusic.id, isPlay: false, havePlay: false));
                                    }
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: new Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomLeft,
                                              end:Alignment.topRight,
                                              colors: [Color(0xFF441DFC),Color(0xFF4E81EB
                                              )]
                                            ),

                                            borderRadius: BorderRadius.circular(16)),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top: index == 2 ? 30 : 70,
                                                left: index == 2 ? 20 : 12,
                                                child: Container(
                                                    width: 180,
                                                    child: Text(
                                                      currentMusic.name,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: "sfproBold",
                                                          color: Colors.white),
                                                    ))),
                                            Positioned(
                                                top: index == 2 ? 60 : 92,
                                                left: index == 2 ? 20 : 12,
                                                child: Container(
                                                  width: 110,
                                                  child: Wrap(
                                                      crossAxisAlignment: WrapCrossAlignment.center,
                                                      children: currentMusic.sounds.icons
                                                          .map((e) => Padding(
                                                        padding: const EdgeInsets.all(3.0),
                                                        child: Container(
                                                            height: 22,
                                                            width: 22,
                                                            child: SvgPicture.asset(
                                                              e,
                                                              fit: BoxFit.scaleDown,
                                                              color: Colors.white,
                                                            )),
                                                      ))
                                                          .toList()),
                                                )),
                                            Positioned(
                                                bottom: index == 2 ? 30 : 10,
                                                right: index == 2 ? 18 : 10,
                                                child: CircleAvatar(
                                                  backgroundColor: Color(0xFFEBF5FB),
                                                  radius: 17,
                                                  child: IconButton(
                                                      iconSize: 19,
                                                      onPressed: () {
                                                        if (IsplayNotifier.IsEffect.value ||
                                                            IsplayNotifier.Isfavori.value) {
                                                          shwDialog(currentMusic);
                                                          return;
                                                        }
                                                        SuggstionController.playedSuggs.forEach((element) {
                                                          print(element.id);
                                                          print("current ID:" + currentID);
                                                          if (element.id != currentID) {
                                                            element.isPlay = false;
                                                            element.havePlay = false;
                                                          }
                                                        });
                                                        if (SuggstionController.getHaveplay(currentMusic.id)) {
                                                          if (SuggstionController.getIsplay(currentMusic.id)) {
                                                            SuggstionController.setIsplay(currentMusic.id, false);
                                                            SuggstionController.pause();
                                                            //  IsplayNotifier.setToggleSugg();
                                                            SuggestionPage.currentPlay = false;
                                                            AudioManager.instance.updateNtf(false);
                                                          } else {
                                                            SuggstionController.setIsplay(currentMusic.id, true);
                                                            SuggstionController.resume();
                                                            // IsplayNotifier.setToggleSugg();
                                                            SuggestionPage.currentPlay = true;
                                                            AudioManager.instance.updateNtf(true);
                                                          }
                                                        } else {
                                                          SuggstionController.setIsplay(currentMusic.id, true);
                                                          SuggstionController.setHaveplay(currentMusic.id, true);
                                                          SuggestionPage.currentPlay = true;
                                                          openMusic(currentMusic);
                                                          // IsplayNotifier.setToggleSugg();
                                                        }
                                                        IsplayNotifier.setToggleSugg();
                                                        currentID = currentMusic.id;
                                                      },
                                                      icon: Icon(SuggstionController.getIsplay(currentMusic.id)
                                                          ? Icons.pause
                                                          : Icons.play_arrow_rounded)),
                                                )),
                                          ],
                                        )),
                                  );
                                },
                              ),
                            );
                          } else if (event is RecLoadingState) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                        SizedBox(height: 150,)
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  shwDialog(DailyMixModel currentMusic) {
    return showDialog(
      context: context,
      builder: (contexts) => CupertinoAlertDialog(
        content: Text(
          "Your effect sounds will be stopped, are you sure",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          CupertinoButton(
              child: Text(
                "no",
              ).tr(),
              onPressed: () => Navigator.pop(context)),
          CupertinoButton(
              child: Text(
                "yes",
                style: TextStyle(fontSize: 16, color: Colors.red),
              ).tr(),
              onPressed: () {
                SuggestionPage.currentPlay = true;
                currentID = currentMusic.id;
                SuggstionController.setIsplay(currentMusic.id, true);
                SuggstionController.setHaveplay(currentMusic.id, true);
                openMusic(currentMusic);
                IsplayNotifier.setToggleSugg();
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  openMusic(DailyMixModel favlar) {
    AudioManager.instance
        .start("assets/ses/City/araba.m4a", "Mindfocus:Relax", desc: favlar.name, cover: "assets/logo.png");
    AudioManager.instance.updateNtf(true);
    if (IsplayNotifier.IsEffect.value) {
      PlayerController.stopall();
    } else if (IsplayNotifier.Isfavori.value) {
      FavoriController.stopall();
    }
    closeMusic();
    int i = 0;
    favlar.sounds.soundPath.forEach((e) {
      AudioPlayer player = new AudioPlayer();
      player.setReleaseMode(ReleaseMode.LOOP);
      AudioCache _audioCache = AudioCache(fixedPlayer: player);
      SuggstionController.Suggestionaudios.add(AudioModel(
          id: player.playerId, sesPath: e, volume: favlar.sounds.volumes[i].toDouble(), players: player));
      _audioCache.loop(e, volume: favlar.sounds.volumes[i].toDouble() / 100);
      i++;
    });
    IsplayNotifier.setTrueSugg();
    IsplayNotifier.IsEffect.value = false;
    IsplayNotifier.Isfavori.value = false;
  }

  closeMusic() {
    if (IsplayNotifier.IsSuggs.value) {
      SuggstionController.stopall();
      IsplayNotifier.setFalseSugg();
    }
  }
}
