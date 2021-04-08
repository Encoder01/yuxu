import 'package:hive/hive.dart';
import 'package:mindfocus/Model/favorites_model.dart';

part 'favorites.g.dart';


@HiveType(typeId: 1)
class Favorites{
  @HiveField(0)
  List<FavoritesModel> favorites;
  @HiveField(1)
  String ID;
  @HiveField(2)
  String Name;
  Favorites({this.favorites,this.ID,this.Name});
}