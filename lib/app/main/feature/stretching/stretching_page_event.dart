part of 'stretching_page_bloc.dart';

sealed class StretchingPageEvent extends BaseEvent {
  StretchingPageEvent();

  factory StretchingPageEvent.initial() => Initial._();

  factory StretchingPageEvent.getStretchingWeeks({required bool isLoading}) => GetStretchingWeeks._(isLoading);

  factory StretchingPageEvent.getStretchingLessons({required String id, required bool isLoading}) => GetStretchingLessons._(id, isLoading);

  factory StretchingPageEvent.changeSelectedWeek({required String id, required bool isLoading}) => ChangeSelectedWeek._(id,isLoading);
}

final class Initial extends StretchingPageEvent {
  Initial._();
}

final class GetStretchingWeeks extends StretchingPageEvent {
  final bool isLoading;

  GetStretchingWeeks._(this.isLoading);
}

final class GetStretchingLessons extends StretchingPageEvent {
  final String id;
  final bool isLoading;

  GetStretchingLessons._(this.id, this.isLoading);
}

final class ChangeSelectedWeek extends StretchingPageEvent {
  final String id;
  final bool isLoading;

  ChangeSelectedWeek._(this.id,this.isLoading);
}
