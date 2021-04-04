part of 'suggestion_bloc.dart';

abstract class SuggestionEvent extends Equatable {
  const SuggestionEvent();
}
class FetchSuggestionEvent extends SuggestionEvent {
  FetchSuggestionEvent();
  @override
  List<Object> get props => throw UnimplementedError();
}
