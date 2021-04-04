import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mindfocus/Model/suggestion_model.dart';

class Suggestion{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<SuggestionsModel> suggs = [];
  List<DocumentSnapshot> documentList;
  DocumentSnapshot _LastDocument;
  DocumentSnapshot _LastDocumentMagaza;

  Future<List<SuggestionsModel>> getSuggestion() async {
    firestore.settings = Settings(persistenceEnabled: false);
    suggs = [];
    Query q = firestore.collection("Suggestion");
    QuerySnapshot querySnapshot = await q.get();
    documentList = querySnapshot.docs;
    _LastDocument = documentList[documentList.length - 1];
    documentList.forEach((element) {
      element.data().forEach((key, value) {
       suggs.add(SuggestionsModel.fromJson(value));
      });
    });
    return suggs;
  }
}