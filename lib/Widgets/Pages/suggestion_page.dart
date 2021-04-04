import 'package:audio_manager/audio_manager.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindfocus/Bloc/suggestion_bloc.dart';
import 'package:mindfocus/Controller/FavoriController.dart';
import 'package:mindfocus/Controller/PlayerController.dart';
import 'package:mindfocus/Controller/SuggestController.dart';
import 'package:mindfocus/Controller/isplaynotifier.dart';
import 'package:mindfocus/Model/audio_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mindfocus/Model/playedFav.dart';
import 'package:mindfocus/Model/suggestion_model.dart';

class SuggestionPage extends StatefulWidget {
  static bool currentPlay = false;

  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  ScrollController _scrollControllers;
  double heig = 250;

  @override
  void initState() {
    BlocProvider.of<SuggestionBloc>(context).add(FetchSuggestionEvent());
    _scrollControllers = ScrollController();
    super.initState();
  }
  String currentID = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF08123A),
      body: Stack(
        children: [
          Positioned.fill(
            top: 160,
            child: SvgPicture.asset("assets/susleme/favourite_page_background.svg")),
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollControllers,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                          width: 500,
                          height: heig,
                          child: SvgPicture.asset(
                            "assets/susleme/homepage.svg",
                            height: 210,
                            fit: BoxFit.fitWidth,
                          )),
                    ],
                  ),
                  ValueListenableBuilder<bool>(
                      valueListenable:IsplayNotifier.PlayerSuggs,
                      builder: (context, value, child) {
                        SuggstionController.playedSuggs = [];
                        return BlocBuilder<SuggestionBloc, SuggestionState>(builder: (context, event) {
                          if (event is SuggestionLoadedState) {
                            return StaggeredGridView.countBuilder(
                              crossAxisCount: 4,
                              itemCount: event.suggs.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                SuggestionsModel currentMusic = event.suggs[index];
                                if(IsplayNotifier.IsSuggs.value){
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
                                  padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5),
                                  child: new Container(
                                      decoration: BoxDecoration(
                                          color: Color(currentMusic.color), borderRadius: BorderRadius.circular(16)),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              top: 70,
                                              left: 12,
                                              child: Container(
                                                  width: 180,
                                                  child: Text(
                                                    currentMusic.name,
                                                    style: TextStyle(fontSize: 18),
                                                  ))),
                                          Positioned(
                                              top: 115,
                                              left: 12,
                                              child: Container(
                                                width: 110,
                                                child: Wrap(
                                                    crossAxisAlignment: WrapCrossAlignment.center,
                                                    children: currentMusic.sounds.icons
                                                        .map((e) => Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: Container(
                                                          height: 20,
                                                          width: 20,
                                                          child: SvgPicture.asset(
                                                            e,
                                                            color: Colors.black,
                                                          )),
                                                    ))
                                                        .toList()),
                                              )),
                                          Positioned(
                                              bottom: 10,
                                              right: 10,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 20,
                                                child: IconButton(
                                                    iconSize: 25,
                                                    onPressed: () {
                                                      if (IsplayNotifier.IsEffect.value||IsplayNotifier.Isfavori.value) {
                                                        shwDialog(currentMusic);
                                                        return;
                                                      }
                                                      SuggstionController.playedSuggs.forEach((element) {
                                                        print(element.id);
                                                        print("current ID:"+currentID);
                                                        if (element.id !=currentID) {
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
                                                        : Icons.play_arrow)),
                                              )),
                                        ],
                                      )),
                                );
                              },
                              staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 2),
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                            );
                          } else if (event is SuggLoadingState) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
                      }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  shwDialog(SuggestionsModel currentMusic) {
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

  openMusic(SuggestionsModel favlar) {
    AudioManager.instance
        .start("assets/ses/City/araba.m4a", "Mindfocus:Relax", desc: favlar.name, cover: "assets/logo.png");
    AudioManager.instance.updateNtf(true);
    if (IsplayNotifier.IsEffect.value) {
      PlayerController.stopall();
    }else if(IsplayNotifier.Isfavori.value){
      FavoriController.stopall();
    }
    closeMusic();
    int i = 0;
    favlar.sounds.soundPath.forEach((e) {
      AudioPlayer player = new AudioPlayer();
      player.setReleaseMode(ReleaseMode.LOOP);
      AudioCache _audioCache = AudioCache(fixedPlayer: player);
      SuggstionController.Suggestionaudios.add(
          AudioModel(id: player.playerId, sesPath: e, volume: favlar.sounds.volume[i].toDouble(), players: player));
      _audioCache.loop(e, volume: favlar.sounds.volume[i].toDouble() / 100);
      i++;
    });
    IsplayNotifier.setTrueSugg();
    IsplayNotifier.IsEffect.value = false;
    IsplayNotifier.Isfavori.value = false;
  }

  closeMusic() {
    if(IsplayNotifier.IsSuggs.value){
      SuggstionController.stopall();
      IsplayNotifier.setFalseSugg();
    }
  }
}
