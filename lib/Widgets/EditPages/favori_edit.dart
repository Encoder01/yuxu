import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindfocus/Controller/FavoriController.dart';
import 'package:mindfocus/Controller/PlayerController.dart';
import 'package:mindfocus/Controller/countProv.dart';
import 'package:mindfocus/Controller/isplaynotifier.dart';
import 'package:mindfocus/Model/favorites.dart';
import 'package:mindfocus/Model/favorites_model.dart';
import 'package:mindfocus/Services/ColorsPack.dart';
import 'package:mindfocus/Widgets/FavoritePage/favorite_page.dart';


class FavoriEdit extends StatefulWidget {
  String favoriID;
  String name;
  Favorites currentFav;
  int index;
  FavoriEdit({this.favoriID,this.index, this.currentFav, this.name});

  @override
  _FavoriEditState createState() => _FavoriEditState();
}

class _FavoriEditState extends State<FavoriEdit> {
  List<FavoritesModel> favs = [];
  TextEditingController _textFieldController = TextEditingController();
  bool favName = false;

  @override
  void initState() {
    favs = widget.currentFav.favorites.toList();
    _textFieldController.text = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF08123A),
        body: Stack(
          children: [
            Positioned(
              top: 50,
              left: 20,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      CounterNotifier.updateUI();
                    },
                    iconSize: 32,
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(bottom: 0, child: Container(child: Image.asset("assets/signpage/Vector1.png"))),
            Positioned(bottom: 0, right: 0, child: Container(child: Image.asset("assets/signpage/Vector2.png"))),
            Positioned(top: 0, right: 0, child: Container(child: Image.asset("assets/signpage/Vector3.png"))),
            Positioned(top: 0, right: 0, child: Container(child: Image.asset("assets/signpage/Vector4.png"))),
            Positioned(top: 150, right: 0, child: Container(child: Image.asset("assets/signpage/Vector5.png"))),
            Positioned(top: 100, left: 0, child: Container(child: Image.asset("assets/signpage/Vector6.png"))),
            ValueListenableBuilder(
                valueListenable: Hive.box<Favorites>("favorites").listenable(),
                builder: (context, Box<Favorites> box, _) {
                  return Positioned.fill(
                    top: 90,
                    left: 30,
                    right: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _textFieldController,
                          decoration: InputDecoration(
                            errorText: favName ? "Enter at most 16 characters and at least 3 characters":null,
                            errorStyle: TextStyle(color: Colors.redAccent),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: widget.name,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        SizedBox(
                          height: 380,
                          child: ListView.builder(
                            itemCount: favs.length,
                            itemBuilder: (_, indexs) {
                              return Wrap(
                                spacing: 0,
                                alignment: WrapAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(top: 7, bottom: 7),
                                      height: 70,
                                      width: 70,
                                      child: SvgPicture.asset(favs[indexs].icon1)),
                                  Container(
                                    height: 70,
                                    width: 180,
                                    child: FlutterSlider(
                                      onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                                        double val = double.parse(lowerValue.toString());
                                        favs[indexs].volume = val;
                                      },
                                      onDragging: (handlerIndex, lowerValue, upperValue) {
                                        double val = double.parse(lowerValue.toString());
                                        print(val / 20);
                                        if (FavoritePage.currentPlay &&
                                            FavoriController.Favoriaudios.isNotEmpty &&
                                            widget.currentFav.ID == widget.favoriID) {
                                          FavoriController.setVolume(
                                              FavoriController.Favoriaudios[indexs].players.playerId, val / 40);
                                        }
                                      },
                                      step: FlutterSliderStep(step: 20),
                                      handlerWidth: 15,
                                      handlerHeight: 28,
                                      jump: true,
                                      tooltip: FlutterSliderTooltip(
                                        disabled: false,
                                      ),
                                      trackBar: FlutterSliderTrackBar(
                                          activeTrackBar: BoxDecoration(
                                              color: Colors.white, borderRadius: BorderRadius.circular(40)),
                                          inactiveTrackBar: BoxDecoration(
                                              color: Color(0xFF47557E), borderRadius: BorderRadius.circular(50))),
                                      handler: FlutterSliderHandler(
                                        decoration: BoxDecoration(),
                                        child: Material(
                                          type: MaterialType.circle,
                                          color: Color(0xFF777BF1),
                                          elevation: 3,
                                          child: Container(
                                            width: 15,
                                            height: 20,
                                          ),
                                        ),
                                      ),
                                      max: 100,
                                      min: 0,
                                      values: [favs[indexs].volume],
                                    ),
                                  ),
                                  Container(
                                      height: 70,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (FavoritePage.currentPlay &&
                                                FavoriController.Favoriaudios.isNotEmpty &&
                                                widget.currentFav.ID == widget.favoriID) {
                                              PlayerController.stop(
                                                  FavoriController.Favoriaudios[indexs].players.playerId);
                                            }
                                            favs.removeAt(indexs);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                        ),
                                      ))
                                ],
                              );
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.3),
                              radius: 27,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 22,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.save,
                                    color: Color(0xFF30313C),
                                  ),
                                  onPressed: () {
                                    if (_textFieldController.text.length < 3) {
                                      favName = true;
                                      setState((){});
                                      return;
                                    } else if(_textFieldController.text.length >14){
                                      favName = true;
                                      setState((){});
                                      return;
                                    }else{
                                      favName = false;
                                      setState((){});
                                      Navigator.pop(context);
                                    }

                                      for (int i = 0; i < box.values.length; i++) {
                                        if (box.getAt(i).ID == widget.favoriID && favs.isNotEmpty&&favName==false) {
                                          box.putAt(i, Favorites(
                                                  favorites: favs,
                                                  ID: widget.favoriID,
                                                  Name: _textFieldController.text));
                                        } else if (box.getAt(i).ID == widget.favoriID && favs.isEmpty){
                                          ColorsPack.i.removeAt(i);
                                          box.deleteAt(i);
                                        }
                                      }
                                  },
                                  iconSize: 22,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Color(0xFFEBF5FB),
                              radius: 20,
                              child: IconButton(
                                  iconSize: 20,
                                  onPressed: () async{
                                    if (FavoritePage.currentPlay && widget.favoriID == widget.currentFav.ID) {
                                      if (IsplayNotifier.Isfavori.value) {
                                        FavoriController.stopall();
                                        IsplayNotifier.setFalseFavori();
                                      }
                                      AudioManager.instance.toPause();
                                    }
                                    for (int i = 0; i < box.values.length; i++) {
                                     if (box.getAt(i).ID == widget.favoriID ){
                                        ColorsPack.i.removeAt(i);
                                        box.deleteAt(i);
                                      }
                                    }
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    color: ColorsPack.colors[ColorsPack.i[widget.index]],
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ));
  }
}
