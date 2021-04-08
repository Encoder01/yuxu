part of 'daily_mix_bloc.dart';

@immutable
abstract class DailyMixState {}

class InitialDailyMixState extends DailyMixState {}

class DailyMixLoadedState extends DailyMixState {
  final List<DailyMixModel> daily;
  DailyMixLoadedState({this.daily});
}

class DailyLoadingState extends DailyMixState{}