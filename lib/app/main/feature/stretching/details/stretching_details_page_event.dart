part of 'stretching_details_page_bloc.dart';

sealed class StretchingDetailsPageEvent extends BaseEvent {
  StretchingDetailsPageEvent();

  factory StretchingDetailsPageEvent.initial(
    StretchingLesson stretchingLesson,
    String weekTitle,
  ) =>
      Initial._(
        stretchingLesson: stretchingLesson,
        weekTitle: weekTitle,
      );
}

final class Initial extends StretchingDetailsPageEvent {
  final StretchingLesson stretchingLesson;
  final String weekTitle;

  Initial._({required this.stretchingLesson, required this.weekTitle});
}
