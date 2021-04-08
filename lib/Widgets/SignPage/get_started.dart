import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindfocus/Services/transforms.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  IndexController _controller;
  Color bg = Colors.pink;
  FixedExtentScrollController controller;

  double _viewportFraction = 1.0;
  String isim ="";
  int sigaraAded=10;
  int paketAded=20;
  double paktFiyat=15.5;
  int icmeSuresi=1;
  String birakmaTarih=DateTime.now().toString();
  ValueNotifier<int> _index=ValueNotifier(0);
  @override
  void initState() {
    _controller = new IndexController();
    controller = new FixedExtentScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.5),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<List<String>>("hashtags").listenable(),
          builder: (context, Box<List<String>> box, _) {
            return Stack(
              children: [
                ValueListenableBuilder(
                    valueListenable: _index,
                    builder: (context, value, _) {
                    return new TransformerPageView(
                        loop: false,
                        index: value,
                        viewportFraction: _viewportFraction,
                        controller: _controller,
                        transformer:  ThreeDTransformer(),
                        onPageChanged: (int index) {
                            _index.value =index;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Container(
                              height: double.infinity,
                              color: Colors.yellow,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 150,
                                    width: 330,
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: new BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff8e9eab),
                                          blurRadius: 8,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            "Sigarayı Bırak'a Hoşgeldiniz!",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 18),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Sigarayı bırakmak gibi zor bir karar aldınız. Tebrikler!",
                                            style: TextStyle(fontSize: 15),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          else if (index == 1) {
                            return Container(
                              color: Colors.blue,
                              child: Center(
                                child: Container(
                                  height: 130,
                                  width: 330,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff8e9eab),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text("Günlük içtiğiniz sigara adedi nedir?",
                                                style:TextStyle(fontSize: 16))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          else if (index == 2) {
                            return Container(
                              color: Colors.indigo,
                              child: Center(
                                child: Container(
                                  height: 130,
                                  width: 330,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff8e9eab),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text("Sigara paketinde kaç sigara bulunurdu?",
                                                style: TextStyle(fontSize: 16))),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          else if (index == 3) {
                            return Container(
                              color: Colors.green,);
                          }
                          else if (index == 4) {
                            return Container(
                              color: Colors.deepPurpleAccent,
                              child: Center(
                                child: Container(
                                  height: 130,
                                  width: 330,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff8e9eab),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text("1 sigarayı kaç dk içinde içiyorsunuz?",
                                                style:TextStyle(fontSize: 16)))),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          else
                            return null;
                        },
                        itemCount: 5);
                  }
                ),
              ],
            );
          }),
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
