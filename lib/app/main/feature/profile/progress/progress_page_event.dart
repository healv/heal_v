part of 'progress_page_bloc.dart';

abstract class ProgressPageEvent {
  ProgressPageEvent();

  factory ProgressPageEvent.initial() => Initial._();

  factory ProgressPageEvent.previousMonth() => PreviousMonth._();

  factory ProgressPageEvent.nextMonth() => NextMonth._();
}

final class Initial extends ProgressPageEvent {
  Initial._();
}

final class PreviousMonth extends ProgressPageEvent {
  PreviousMonth._();
}

final class NextMonth extends ProgressPageEvent {
  NextMonth._();
}
