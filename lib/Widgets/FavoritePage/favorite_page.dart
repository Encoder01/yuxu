import 'dart:math';

import 'package:audio_manager/audio_manager.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:mindfocus/Bloc/favplayer_bloc.dart';
import 'package:mindfocus/Controller/FavoriController.dart';
import 'package:mindfocus/Controller/PlayerController.dart';
import 'package:mindfocus/Controller/SuggestController.dart';
import 'package:mindfocus/Controller/isplaynotifier.dart';
import 'package:mindfocus/Model/audio_model.dart';
import 'package:mindfocus/Model/favorites.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindfocus/Model/playedFav.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mindfocus/Services/ColorsPack.dart';
import 'package:mindfocus/Services/authentication.dart';
import 'package:mindfocus/Widgets/DiscoveryPage/suggestion_page.dart';
import 'package:mindfocus/Widgets/EditPages/efekt_edit.dart';
import 'package:mindfocus/Widgets/EditPages/favori_edit.dart';

class FavoritePage extends StatefulWidget {
  static bool currentPlay = true;

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String currentId = "";
  Random random = new Random();

  ScrollController _scrollController;
  ValueNotifier<double> containerHeig=ValueNotifier(WidgetsBinding.instance.window.physicalSize.width* 35 / 100);
  double _scrollPosition=0;
  void setupAudio() {
    AudioManager.instance.onEvents((events, args) {
      print("event: $events -----  arg: $args");

      if (events == AudioManagerEvents.playstatus) {
        if (args) {
          //bildirim panelinden gelen play/pause işlemi
          if (IsplayNotifier.Isfavori.value) {
            if (!FavoritePage.currentPlay) {
              FavoriController.resume();
              print("AudioManager resume Favori");
              FavoritePage.currentPlay = true;
              BlocProvider.of<FavplayerBloc>(context).add(FetchPlayerEvent(isplayed: true, id: currentId));
            }
          } else if (IsplayNotifier.IsEffect.value) {
            print("AudioManager resume Effect");
            IsplayNotifier.setTruePlay();
            PanelDialog.controller.resume();
            PlayerController.resume();
          } else if (IsplayNotifier.IsSuggs.value) {
            if (!SuggestionPage.currentPlay) {
              SuggstionController.resume();
              print("AudioManager resume Favori");
              SuggestionPage.currentPlay = true;
              IsplayNotifier.setToggleSugg();
            }
          }
        } else {
          if (IsplayNotifier.Isfavori.value) {
            print("AudioManager pause Favori");
            if (FavoritePage.currentPlay) {
              FavoriController.pause();
              FavoritePage.currentPlay = false;
              BlocProvider.of<FavplayerBloc>(context).add(FetchPlayerEvent(isplayed: false, id: currentId));
            }
          } else if (IsplayNotifier.IsEffect.value) {
            print("AudioManager pause Effect");
            IsplayNotifier.setFalsePlay();
            PanelDialog.controller.pause();
            PlayerController.pause();
          } else if (IsplayNotifier.IsSuggs.value) {
            print("AudioManager pause Favori");
            if (SuggestionPage.currentPlay) {
              SuggstionController.pause();
              SuggestionPage.currentPlay = false;
              IsplayNotifier.setToggleSugg();
            }
          }
        }
      }
    });
  }

  void changeIndex() {
    Hive.box<Favorites>("favorites").values.forEach((element) {
      ColorsPack.i.add(random.nextInt(16));
      ColorsPack.j.add(random.nextInt(11));
      print(ColorsPack.i.length);
    });
  }

  @override
  void initState() {
    BlocProvider.of<FavplayerBloc>(context).add(FetchPlayerEvent(isplayed: false));
    setupAudio();
    changeIndex();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _scrollPosition=_scrollController.position.pixels;
      if(!_scrollPosition.isNegative){
        if(_scrollPosition<=(WidgetsBinding.instance.window.physicalSize.width* 35 / 100)-1){
          containerHeig.value=(WidgetsBinding.instance.window.physicalSize.width* 35 / 100)-(_scrollPosition*60/100);
        }else{
          containerHeig.value=0;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF190333),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Stack(
                  children: [
                    ValueListenableBuilder<double>(
                        valueListenable: containerHeig,
                        builder: (context,  value, _) {
                          return Container(
                              width: 500,
                              height: value,
                              child: SvgPicture.asset(
                                "assets/susleme/favorite.svg",
                                height: 250,
                                fit: BoxFit.cover,
                              ));
                        }
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Colors.black.withOpacity(0.7), Colors.transparent])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Favorites",
                              style:
                              TextStyle(color: Colors.white, fontSize: 28, fontFamily: "sfproBold"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                ValueListenableBuilder(
                    valueListenable: Hive.box<Favorites>("favorites").listenable(),
                    builder: (context, Box<Favorites> box, _) {
                      FavoriController.playedFav = [];
                      return BlocBuilder<FavplayerBloc, FavplayerState>(builder: (context, eventstate) {
                        if (eventstate is FavplayerLoadedState) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: StaggeredGridView.countBuilder(
                              crossAxisCount: 4,
                              shrinkWrap: true,
                              staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 2),
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.only(top: 8.0),
                              itemCount: box.length,
                              itemBuilder: (BuildContext context, int index) {
                                Favorites currentMusic = box.getAt(index);
                                if (IsplayNotifier.Isfavori.value) {
                                  if (currentId == currentMusic.ID && IsplayNotifier.Isfavori.value) {
                                    FavoriController.playedFav.add(Played(
                                        id: currentMusic.ID,
                                        isPlay: FavoritePage.currentPlay,
                                        havePlay: FavoritePage.currentPlay));
                                  } else {
                                    FavoriController.playedFav
                                        .add(Played(id: currentMusic.ID, isPlay: false, havePlay: false));
                                  }
                                }
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => FavoriEdit(
                                              favoriID: currentMusic.ID,
                                              currentFav: currentMusic,
                                              name: currentMusic.Name,
                                              index: index,
                                            )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: new Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage("assets/susleme/dalga.png"),
                                                alignment: Alignment.bottomCenter,
                                                fit: BoxFit.fitWidth),
                                            gradient: LinearGradient(
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight,
                                              colors: [
                                                ColorsPack.colors[ColorsPack.i[index]],
                                                ColorsPack.colors2[ColorsPack.i[index]],
                                              ]
                                            ),
                                            borderRadius: BorderRadius.circular(16)),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top: 50,
                                                left: 10,
                                                child: Container(
                                                    width: 180,
                                                    child: Text(
                                                      currentMusic.Name,
                                                      style: TextStyle(fontSize: 18, color: Colors.white),
                                                    ))),
                                            Positioned(
                                                top: 77,
                                                left: 10,
                                                child: Container(
                                                  width: 140,
                                                  child: Wrap(
                                                      crossAxisAlignment: WrapCrossAlignment.center,
                                                      children: currentMusic.favorites
                                                          .map((e) => Padding(
                                                        padding: const EdgeInsets.all(2.0),
                                                        child: Container(
                                                            height: 22,
                                                            width: 22,
                                                            child: SvgPicture.asset(
                                                              e.icon1,
                                                              color: Colors.white,
                                                            )),
                                                      ))
                                                          .toList()),
                                                )),
                                            Positioned(
                                                bottom: 10,
                                                right: 10,
                                                child: CircleAvatar(
                                                  backgroundColor: Color(0xFFEBF5FB),
                                                  radius: 20,
                                                  child: IconButton(
                                                      iconSize: 25,
                                                      onPressed: () {
                                                        if (IsplayNotifier.IsEffect.value ||
                                                            IsplayNotifier.IsSuggs.value) {
                                                          shwDialog(currentMusic);
                                                          return;
                                                        }
                                                        FavoriController.playedFav.forEach((element) {
                                                          if (element.id != currentMusic.ID) {
                                                            element.isPlay = false;
                                                            element.havePlay = false;
                                                          }
                                                        });
                                                        if (FavoriController.getHaveplay(currentMusic.ID)) {
                                                          if (FavoriController.getIsplay(currentMusic.ID)) {
                                                            FavoriController.setIsplay(currentMusic.ID, false);
                                                            FavoriController.pause();
                                                            FavoritePage.currentPlay = false;
                                                            AudioManager.instance.updateNtf(false);
                                                          } else {
                                                            FavoriController.setIsplay(currentMusic.ID, true);
                                                            FavoriController.resume();
                                                            FavoritePage.currentPlay = true;
                                                            AudioManager.instance.updateNtf(true);
                                                          }
                                                        } else {
                                                          openMusic(currentMusic);
                                                          FavoriController.setIsplay(currentMusic.ID, true);
                                                          FavoriController.setHaveplay(currentMusic.ID, true);
                                                          FavoritePage.currentPlay = true;
                                                        }
                                                        BlocProvider.of<FavplayerBloc>(context)
                                                            .add(FetchPlayerEvent(isplayed: true, id: currentMusic.ID));
                                                        currentId = currentMusic.ID;
                                                      },
                                                      icon: Icon(
                                                          FavoriController.getIsplay(currentMusic.ID)
                                                              ? Icons.pause
                                                              : Icons.play_arrow,
                                                          color: ColorsPack.colors[ColorsPack.i[index]])),
                                                )),
                                          ],
                                        )),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      });
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  shwDialog(Favorites currentMusic) {
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
                FavoritePage.currentPlay = true;
                currentId = currentMusic.ID;
                FavoriController.setIsplay(currentMusic.ID, true);
                FavoriController.setHaveplay(currentMusic.ID, true);
                openMusic(currentMusic);
                BlocProvider.of<FavplayerBloc>(context).add(FetchPlayerEvent(
                  isplayed: false,
                ));
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  openMusic(Favorites favlar) {
    AudioManager.instance
        .start("assets/ses/City/araba.m4a", "Mindfocus:Relax", desc: favlar.Name, cover: "assets/logo.png");
    AudioManager.instance.updateNtf(true);
    if (IsplayNotifier.IsEffect.value) {
      PlayerController.stopall();
    } else if (IsplayNotifier.IsSuggs.value) {
      SuggstionController.stopall();
    }
    closeMusic();
    favlar.favorites.forEach((e) {
      AudioPlayer player = new AudioPlayer();
      player.setReleaseMode(ReleaseMode.LOOP);
      AudioCache _audioCache = AudioCache(fixedPlayer: player);
      FavoriController.Favoriaudios.add(
          AudioModel(id: player.playerId, iconFav: e.icon1, sesPath: e.sesPath, volume: e.volume, players: player));
      _audioCache.loop(e.sesPath, volume: e.volume / 100);
    });
    IsplayNotifier.setTrueFavori();
    IsplayNotifier.IsEffect.value = false;
    IsplayNotifier.IsSuggs.value = false;
  }

  closeMusic() {
    if (IsplayNotifier.Isfavori.value) {
      FavoriController.stopall();
      IsplayNotifier.setFalseFavori();
    }
  }
}
