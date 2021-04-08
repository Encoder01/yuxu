import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindfocus/Model/recommend_model.dart';
import 'package:mindfocus/Model/dailymix_model.dart';

class Suggestion{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DailyMixModel> daily = [];
  List<DailyMixModel> recomm = [];
  List<String> quotes = [];
  Future<List<DailyMixModel>> getRecommend() async {
    firestore.settings = Settings(persistenceEnabled: false);
    recomm = [];
    DocumentReference q = firestore.collection("Suggestion").doc("recommend");
    DocumentSnapshot querySnapshot = await q.get();
    querySnapshot.data().forEach((key, value) {

      recomm.add(DailyMixModel.fromJson(value));
    });
    return recomm;
  }
  Future<List<DailyMixModel>> getDailyMix() async {
    firestore.settings = Settings(persistenceEnabled: false);
    daily = [];
    DocumentReference q = firestore.collection("Suggestion").doc("dailyMix");
    DocumentSnapshot querySnapshot = await q.get();
    print(querySnapshot.data().toString());
    querySnapshot.data().forEach((key, value) {

      daily.add(DailyMixModel.fromJson(value));
    });
    return daily;
  }
  Future<List<String>> getQuotes() async {
    quotes = [];
    DocumentReference q = firestore.collection("Suggestion").doc("quotes");
    DocumentSnapshot querySnapshot = await q.get();
    querySnapshot.data().forEach((key, value) {

      value.forEach((e){
        quotes.add(e);
      });
    });
    return quotes;
  }
}