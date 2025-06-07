part of 'audio_page_bloc.dart';

sealed class AudioPageSideEffect implements SideEffect {
  const AudioPageSideEffect();

  factory AudioPageSideEffect.lessonCompleted({required LoopMode loopMode, required LessonTypeEnum? lessonTypeEnum}) => LessonCompletedEffect(loopMode,lessonTypeEnum);
}

class LessonCompletedEffect extends AudioPageSideEffect {
  final LoopMode loopMode;
  LessonTypeEnum? lessonTypeEnum;

  LessonCompletedEffect(this.loopMode,this.lessonTypeEnum);
}
