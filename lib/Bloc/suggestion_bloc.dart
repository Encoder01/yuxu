import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindfocus/Model/suggestion_model.dart';
import 'package:mindfocus/Services/Suggestion.dart';

part 'suggestion_event.dart';
part 'suggestion_state.dart';

class SuggestionBloc extends Bloc<SuggestionEvent, SuggestionState> {
  SuggestionBloc() : super(SuggestionInitial());

  @override
  Stream<SuggestionState> mapEventToState(
    SuggestionEvent event,
  ) async* {
    if (event is FetchSuggestionEvent){
      try{
        yield SuggLoadingState();
        List<SuggestionsModel> sugg =
        await Suggestion().getSuggestion();
        yield SuggestionLoadedState(suggs: sugg);
      }
      catch (_) {
        yield state;
      }
    }
  }
}
