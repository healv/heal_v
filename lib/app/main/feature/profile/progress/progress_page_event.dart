part of 'progress_page_bloc.dart';

abstract class ProgressPageEvent {
  ProgressPageEvent();

  factory ProgressPageEvent.initial() => Initial._();

  factory ProgressPageEvent.totalProgress() => TotalProgress._();

  factory ProgressPageEvent.dailyProgressList({
    required String startDate,
    required String endDate,
  }) =>
      DailyProgressList._(startDate: startDate, endDate: endDate);

  factory ProgressPageEvent.previousMonth() => PreviousMonth._();

  factory ProgressPageEvent.nextMonth() => NextMonth._();
}

final class Initial extends ProgressPageEvent {
  Initial._();
}

final class TotalProgress extends ProgressPageEvent {
  TotalProgress._();
}

final class DailyProgressList extends ProgressPageEvent {
  final String startDate;
  final String endDate;

  DailyProgressList._({required this.startDate, required this.endDate});
}

final class PreviousMonth extends ProgressPageEvent {
  PreviousMonth._();
}

final class NextMonth extends ProgressPageEvent {
  NextMonth._();
}
