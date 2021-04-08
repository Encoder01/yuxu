import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mindfocus/Model/dailymix_model.dart';
import 'package:mindfocus/Services/DBservice.dart';
part 'daily_mix_event.dart';
part 'daily_mix_state.dart';

class DailyMixBloc extends Bloc<DailyMixEvent, DailyMixState> {
  DailyMixBloc() : super(InitialDailyMixState());

  @override
  Stream<DailyMixState> mapEventToState(DailyMixEvent event) async* {
    if (event is FetchDailyMixEvent){
      try{
        yield DailyLoadingState();
        List<DailyMixModel> daily =
        await Suggestion().getDailyMix();
        yield DailyMixLoadedState(daily: daily);
      }
      catch (_) {
        yield state;
      }
    }
  }
}
