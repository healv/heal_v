part of 'stretching_video_page_bloc.dart';

sealed class StretchingVideoPageEffect implements SideEffect {
  const StretchingVideoPageEffect();

  factory StretchingVideoPageEffect.lessonCompleted() => LessonCompleted();
}

class LessonCompleted extends StretchingVideoPageEffect {
  LessonCompleted();
}
