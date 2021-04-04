part of 'favplayer_bloc.dart';

@immutable
abstract class FavplayerEvent {}
class FetchPlayerEvent extends FavplayerEvent {
  bool isplayed;
  String id="";
  FetchPlayerEvent({@required this.isplayed,this.id});

}