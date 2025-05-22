part of 'breathing_page_bloc.dart';

sealed class BreathingPageEvent extends BaseEvent {
  BreathingPageEvent();

  factory BreathingPageEvent.initial() => Initial._();

  factory BreathingPageEvent.getBreathingWeeks() => GetBreathingWeeks._();

  factory BreathingPageEvent.getBreathingLessons({required String id}) => GetBreathingLessons._(id);

  factory BreathingPageEvent.changeSelectedWeek({required String id}) => ChangeSelectedWeek._(id);
}

final class Initial extends BreathingPageEvent {
  Initial._();
}

final class GetBreathingWeeks extends BreathingPageEvent {
  GetBreathingWeeks._();
}

final class GetBreathingLessons extends BreathingPageEvent {
  final String id;

  GetBreathingLessons._(this.id);
}

final class ChangeSelectedWeek extends BreathingPageEvent {
  final String id;

  ChangeSelectedWeek._(this.id);
}
