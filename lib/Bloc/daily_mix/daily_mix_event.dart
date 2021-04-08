part of 'daily_mix_bloc.dart';

@immutable
abstract class DailyMixEvent {}
class FetchDailyMixEvent extends DailyMixEvent {
  FetchDailyMixEvent();
}
