part of 'quotes_bloc.dart';

@immutable
abstract class QuotesState {}

class InitialQuotesState extends QuotesState {}

class QuotesLoadedState extends QuotesState {
  final List<String> quotes;
  QuotesLoadedState({this.quotes});
}
class QuoLoadingState extends QuotesState{}