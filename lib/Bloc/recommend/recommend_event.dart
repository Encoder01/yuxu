part of 'recommend_bloc.dart';

@immutable
abstract class RecommendEvent {}
class FetchRecommendEvent extends RecommendEvent {
  FetchRecommendEvent();
}