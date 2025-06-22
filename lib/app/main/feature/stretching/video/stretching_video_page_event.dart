part of 'stretching_video_page_bloc.dart';

sealed class StretchingVideoPageEvent extends BaseEvent {
  const StretchingVideoPageEvent();

  factory StretchingVideoPageEvent.initial(
    StretchingLesson stretchingLesson,
    String weekId,
  ) =>
      _Initial(
        stretchingLesson: stretchingLesson,
        weekId: weekId,
      );

  factory StretchingVideoPageEvent.lessonFinished() => const _LessonFinished();
}

final class _Initial extends StretchingVideoPageEvent {
  final StretchingLesson stretchingLesson;
  final String weekId;

  const _Initial({required this.stretchingLesson, required this.weekId});
}

final class _LessonFinished extends StretchingVideoPageEvent {
  const _LessonFinished();
}
