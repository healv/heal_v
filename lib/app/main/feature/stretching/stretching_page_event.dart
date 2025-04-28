part of 'stretching_page_bloc.dart';

sealed class StretchingPageEvent extends BaseEvent {
  StretchingPageEvent();

  factory StretchingPageEvent.initial() => Initial._();

  factory StretchingPageEvent.getStretchingWeeks() => GetStretchingWeeks._();

  factory StretchingPageEvent.getStretchingLessons({required String id}) => GetStretchingLessons._(id);

  factory StretchingPageEvent.changeSelectedWeek({required String id}) => ChangeSelectedWeek._(id);
}

final class Initial extends StretchingPageEvent {
  Initial._();
}

final class GetStretchingWeeks extends StretchingPageEvent {
  GetStretchingWeeks._();
}

final class GetStretchingLessons extends StretchingPageEvent {
  final String id;

  GetStretchingLessons._(this.id);
}

final class ChangeSelectedWeek extends StretchingPageEvent {
  final String id;

  ChangeSelectedWeek._(this.id);
}
