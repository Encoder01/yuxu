import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mindfocus/Services/DBservice.dart';

part 'quotes_event.dart';

part 'quotes_state.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  QuotesBloc() : super(InitialQuotesState());

  @override
  Stream<QuotesState> mapEventToState(QuotesEvent event) async* {
    if (event is FetchQuotesEvent){
      try{
        yield QuoLoadingState();
        List<String> quo =
        await Suggestion().getQuotes();
        yield QuotesLoadedState(quotes: quo);
      }
      catch (_) {
        yield state;
      }
    }
  }
}
