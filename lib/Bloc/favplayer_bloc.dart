import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favplayer_event.dart';
part 'favplayer_state.dart';

class FavplayerBloc extends Bloc<FavplayerEvent, FavplayerState> {
  FavplayerBloc() : super(FavplayerInitial());

  @override
  Stream<FavplayerState> mapEventToState(
    FavplayerEvent event,
  ) async* {
    if (event is FetchPlayerEvent){
      try{
        print(event.isplayed);
        yield FavplayerLoadedState(isplayed:event.isplayed,id: event.id);

      }
      catch (_) {
        yield state;
      }
    }
  }
}
