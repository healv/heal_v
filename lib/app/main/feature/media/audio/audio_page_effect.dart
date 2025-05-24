part of 'audio_page_bloc.dart';

sealed class AudioPageSideEffect implements SideEffect {
  const AudioPageSideEffect();

  factory AudioPageSideEffect.lessonCompleted({required LoopMode loopMode}) => LessonCompletedEffect(loopMode);
}

class LessonCompletedEffect extends AudioPageSideEffect {
  final LoopMode loopMode;

  LessonCompletedEffect(this.loopMode);
}
