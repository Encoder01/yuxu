import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindfocus/Controller/PlayerController.dart';
import 'package:mindfocus/Controller/countProv.dart';
import 'package:mindfocus/Controller/isplaynotifier.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mindfocus/Services/fade_out.dart';
import 'package:mindfocus/Widgets/EditPages/efekt_edit.dart';
import 'package:mindfocus/Widgets/Pages/settings_page.dart';
import 'package:timer_count_down/timer_count_down.dart';

class PanelButton extends StatefulWidget {
  Color color;
  PanelButton(this.color);
  @override
  _PanelButtonState createState() => _PanelButtonState();
}

class _PanelButtonState extends State<PanelButton> with TickerProviderStateMixin {
  bool visible;

  AnimationController _controller;
  var scaleAnimation;
  CounterNotifier counterNotifier;
  @override
  void initState() {
    counterNotifier = CounterNotifier(0);
    visible = false;
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    ) ..addListener(() {
      setState(() {});
    });
    scaleAnimation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.linearToEaseOut));
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    counterNotifier.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext contexts) {
         return ValueListenableBuilder<int>(
          valueListenable: CounterNotifier.EfektSayiKontrol,
          builder: (contexts, value, Widget child) {
            if (value == 1 && !visible) {
              visible = true;
              IsplayNotifier.setTruePlay();
              IsplayNotifier.IsEffect.value=true;
              AudioManager.instance.start("assets/ses/City/araba.m4a", "Mindfocus:Relax",desc:"notif".tr(),cover:"assets/logo.png");
              AudioManager.instance.updateNtf(true);
              _controller.forward();
            } else if (value == 0 && visible) {
              visible = false;
              IsplayNotifier.setFalsePlay();
              IsplayNotifier.IsEffect.value=false;
              if(!IsplayNotifier.Isfavori.value&&!IsplayNotifier.IsSuggs.value){
                AudioManager.instance.toPause();
              }
              _controller.reverse();
            }
            return Transform.scale(
              scale: scaleAnimation.value,
              child: Container(
                height: 60,
                color: widget.color,
                child: Stack(
                  children: [
                    Positioned(top:5,left:10,child: Text("Edit Your Sounds")),

                    Positioned(
                      bottom: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                        PlayerController.Players.isNotEmpty?PlayerController.Players.map((e)
                        => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(e.iconFav,width: 20,height: 20,fit: BoxFit.fitHeight,),
                        )).toList():[],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PanelDialog()));
                        },
                        iconSize: 32,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
      );
  }

}
