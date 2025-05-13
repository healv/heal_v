part of 'stretching_video_page_bloc.dart';

sealed class StretchingVideoPageEvent extends BaseEvent {
  const StretchingVideoPageEvent();

  factory StretchingVideoPageEvent.initial(StretchingLesson stretchingLesson) => _Initial(stretchingLesson: stretchingLesson);
}

final class _Initial extends StretchingVideoPageEvent {
  final StretchingLesson stretchingLesson;

  const _Initial({required this.stretchingLesson});
}
