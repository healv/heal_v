part of 'progress_bloc.dart';

sealed class ProgressEvent extends BaseEvent {
  const ProgressEvent();

  factory ProgressEvent.initial() => Initial._();

  factory ProgressEvent.getDailyProgress({String? date}) => GetDailyProgress._(date);

  factory ProgressEvent.getTreeGrowth() => GetTreeGrowth._();
}

class Initial extends ProgressEvent {
  Initial._();
}

class GetDailyProgress extends ProgressEvent {
  String? date;

  GetDailyProgress._(this.date);
}

class GetTreeGrowth extends ProgressEvent {
  GetTreeGrowth._();
}
