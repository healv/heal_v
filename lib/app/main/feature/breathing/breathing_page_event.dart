part of 'breathing_page_bloc.dart';

sealed class BreathingPageEvent extends BaseEvent {
  BreathingPageEvent();

  factory BreathingPageEvent.initial() => Initial._();

  factory BreathingPageEvent.getBreathingWeeks({bool isLoading = true}) => GetBreathingWeeks._(isLoading);

  factory BreathingPageEvent.getBreathingLessons({required String id, bool isLoading = true}) => GetBreathingLessons._(id, isLoading);

  factory BreathingPageEvent.changeSelectedWeek({required String id, bool isLoading = true}) => ChangeSelectedWeek._(id, isLoading);
}

final class Initial extends BreathingPageEvent {
  Initial._();
}

final class GetBreathingWeeks extends BreathingPageEvent {
  final bool isLoading;

  GetBreathingWeeks._(this.isLoading);
}

final class GetBreathingLessons extends BreathingPageEvent {
  final String id;
  final bool isLoading;

  GetBreathingLessons._(this.id, this.isLoading);
}

final class ChangeSelectedWeek extends BreathingPageEvent {
  final String id;
  final bool isLoading;

  ChangeSelectedWeek._(this.id, this.isLoading);
}
