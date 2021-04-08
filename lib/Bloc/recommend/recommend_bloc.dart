import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mindfocus/Model/dailymix_model.dart';
import 'package:mindfocus/Model/recommend_model.dart';
import 'package:mindfocus/Services/DBservice.dart';

part 'recommend_event.dart';

part 'recommend_state.dart';

class RecommendBloc extends Bloc<RecommendEvent, RecommendState> {
  RecommendBloc() : super(InitialRecommendState());

  @override
  Stream<RecommendState> mapEventToState(RecommendEvent event) async* {
    if (event is FetchRecommendEvent){
      try{
        yield RecLoadingState();
        List<DailyMixModel> sugg =
        await Suggestion().getRecommend();
        yield RecommendLoadedState(suggs: sugg);
      }
      catch (_) {
        yield state;
      }
    }
  }
}
