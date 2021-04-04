part of 'suggestion_bloc.dart';

abstract class SuggestionState extends Equatable {
  const SuggestionState();
}

class SuggestionInitial extends SuggestionState {
  @override
  List<Object> get props => [];
}

class SuggestionLoadedState extends SuggestionState {
  final List<SuggestionsModel> suggs;
  SuggestionLoadedState({this.suggs});

  @override
  List<Object> get props => [suggs];
}

class SuggLoadingState extends SuggestionState{
  @override
  List<Object> get props => throw UnimplementedError();
}