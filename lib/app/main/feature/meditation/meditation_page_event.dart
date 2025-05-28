part of 'meditation_page_bloc.dart';

sealed class MeditationPageEvent extends BaseEvent {
  MeditationPageEvent();

  factory MeditationPageEvent.initial() => Initial._();

  factory MeditationPageEvent.getMeditationWeeks({bool isLoading = true}) => GetMeditationWeeks._(isLoading);

  factory MeditationPageEvent.getMeditationLessons({required String id, bool isLoading = true}) => GetMeditationLessons._(id, isLoading);

  factory MeditationPageEvent.changeSelectedWeek({required String id, bool isLoading = true}) => ChangeSelectedWeek._(id, isLoading);
}

final class Initial extends MeditationPageEvent {
  Initial._();
}

final class GetMeditationWeeks extends MeditationPageEvent {
  final bool isLoading;

  GetMeditationWeeks._(this.isLoading);
}

final class GetMeditationLessons extends MeditationPageEvent {
  final String id;
  final bool isLoading;

  GetMeditationLessons._(this.id, this.isLoading);
}

final class ChangeSelectedWeek extends MeditationPageEvent {
  final String id;
  final bool isLoading;

  ChangeSelectedWeek._(this.id, this.isLoading);
}
