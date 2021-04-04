part of 'favplayer_bloc.dart';

@immutable
abstract class FavplayerState {}

class FavplayerInitial extends FavplayerState {}
class FavplayerLoadedState extends FavplayerState {
  bool isplayed=false;
  String id="";
  FavplayerLoadedState({this.isplayed,this.id});
}