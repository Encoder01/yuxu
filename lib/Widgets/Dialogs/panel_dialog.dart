import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:mindfocus/Controller/PlayerController.dart';
import 'package:mindfocus/Controller/countProv.dart';


class PanelDialog extends StatefulWidget {
  @override
  _PanelDialogState createState() => _PanelDialogState();
}

class _PanelDialogState extends State<PanelDialog> {


  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
        content: Container(
          padding: EdgeInsets.zero,
          height: 260,
          width: 300,
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: StatefulBuilder(
                builder:(BuildContext _, StateSetter setState ) =>(
                    ListView.builder(
                      itemCount: PlayerController.Players.length,
                      itemBuilder: (_, indexs) {
                        return Wrap(
                          spacing: 0,
                          alignment: WrapAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: 7,bottom: 7),
                                height: 55,
                                width: 55,
                                child: SvgPicture.asset(PlayerController.audios
                                    .singleWhere((element) =>
                                element.id ==
                                    PlayerController.Players[indexs].players.playerId)
                                    .icon1)),
                            Container(
                              height: 55,
                              width: 110,
                              child: FlutterSlider(
                                onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                                  PlayerController.audios
                                      .singleWhere((element) =>
                                  element.id ==
                                      PlayerController.Players[indexs].players.playerId)
                                      .volume = lowerValue;
                                  context.read<CounterNotifier>().updateUI();

                                },
                                onDragging: (handlerIndex, lowerValue, upperValue) {
                                  PlayerController.setVolume(
                                      PlayerController.Players[indexs].players.playerId,
                                      lowerValue / (PlayerController.audios[indexs].sesPath=='ses/Mix/mix_kalp.m4a'?10:100));
                                },
                                handlerWidth: 20,
                                handlerHeight: 15,
                                tooltip: FlutterSliderTooltip(
                                  disabled: true,
                                ),
                                trackBar:  FlutterSliderTrackBar(
                                  activeTrackBar:  BoxDecoration(
                                      color: PlayerController.audios
                                          .singleWhere((element) =>
                                      element.id ==
                                          PlayerController.Players[indexs].players.playerId)
                                          .color[1],
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                ),
                                handler: FlutterSliderHandler(
                                  decoration: BoxDecoration(),
                                  child: Material(
                                    type: MaterialType.circle,
                                    color: PlayerController.audios
                                        .singleWhere((element) =>
                                    element.id ==
                                        PlayerController.Players[indexs].players.playerId)
                                        .color[1],
                                    elevation: 3,
                                    child: Container(
                                      width: 15,
                                      height: 20,
                                    ),
                                  ),
                                ),
                                max: 100,
                                min: 0,
                                values: [
                                  PlayerController.audios
                                      .singleWhere((element) =>
                                  element.id ==
                                      PlayerController.Players[indexs].players.playerId)
                                      .volume
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                                height: 55,
                                child: IconButton(
                                  onPressed: () {
                                    setState((){
                                      PlayerController.audios
                                          .singleWhere((element) =>
                                      element.id ==
                                          PlayerController.Players[indexs].players.playerId)
                                          .visible = false;
                                      PlayerController.stop(
                                          PlayerController.Players[indexs].players.playerId);
                                      PlayerController.Players.removeAt(indexs);
                                    });
                                    context.read<CounterNotifier>().decrement();
                                    if(context.read<CounterNotifier>().sayiKontrol==0)
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                ))
                          ],
                        );
                      },
                    )),
              )

          ),
        ));
  }
}
