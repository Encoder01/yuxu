part of 'recommend_bloc.dart';

@immutable
abstract class RecommendState {}

class InitialRecommendState extends RecommendState {}

class RecommendLoadedState extends RecommendState {
  final List<DailyMixModel> suggs;
  RecommendLoadedState({this.suggs});
}
class RecLoadingState extends RecommendState{}