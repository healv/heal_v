part of 'meditation_page_bloc.dart';

sealed class MeditationPageEvent extends BaseEvent {
  MeditationPageEvent();

  factory MeditationPageEvent.initial() => Initial._();

  factory MeditationPageEvent.getMeditationWeeks() => GetMeditationWeeks._();

  factory MeditationPageEvent.getMeditationLessons({required String id}) => GetMeditationLessons._(id);

  factory MeditationPageEvent.changeSelectedWeek({required String id}) => ChangeSelectedWeek._(id);
}

final class Initial extends MeditationPageEvent {
  Initial._();
}

final class GetMeditationWeeks extends MeditationPageEvent {
  GetMeditationWeeks._();
}

final class GetMeditationLessons extends MeditationPageEvent {
  final String id;

  GetMeditationLessons._(this.id);
}

final class ChangeSelectedWeek extends MeditationPageEvent {
  final String id;

  ChangeSelectedWeek._(this.id);
}
