import 'package:hive/hive.dart';
part 'favorites_model.g.dart';
@HiveType(typeId: 0)
class FavoritesModel{
  @HiveField(3)
  String icon1;
  @HiveField(2)
  String sesPath;
  @HiveField(1)
  double volume;
  FavoritesModel({this.volume,this.icon1,this.sesPath});
}