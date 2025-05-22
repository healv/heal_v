part of 'stretching_details_page_bloc.dart';

sealed class StretchingDetailsPageEvent extends BaseEvent {
  StretchingDetailsPageEvent();

  factory StretchingDetailsPageEvent.initial({
    required String weekTitle,
    required String weekId,
    required String lessonId,
  }) =>
      Initial._(
        weekTitle: weekTitle,
        weekId: weekId,
        lessonId: lessonId,
      );
}

final class Initial extends StretchingDetailsPageEvent {
  final String weekTitle;
  final String weekId;
  final String lessonId;

  Initial._({required this.weekTitle, required this.weekId, required this.lessonId});
}
