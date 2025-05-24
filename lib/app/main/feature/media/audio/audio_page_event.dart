part of 'audio_page_bloc.dart';

sealed class AudioPageEvent extends BaseEvent {
  const AudioPageEvent();

  factory AudioPageEvent.initial({
    required LessonTypeEnum lessonTypeEnum,
    required String id,
    required String weekId,
    required String title,
    required String description,
    required String previewUrl,
    required bool isCompleted,
  }) =>
      _Initial(
        lessonTypeEnum: lessonTypeEnum,
        id: id,
        weekId: weekId,
        title: title,
        description: description,
        previewUrl: previewUrl,
        isCompleted: isCompleted,
      );

  factory AudioPageEvent.lessonCompleted({required LoopMode loopMode}) => _LessonCompleted(loopMode);
}

final class _Initial extends AudioPageEvent {
  final LessonTypeEnum lessonTypeEnum;
  final String id;
  final String weekId;
  final String title;
  final String description;
  final String previewUrl;
  final bool isCompleted;

  const _Initial({
    required this.lessonTypeEnum,
    required this.id,
    required this.weekId,
    required this.title,
    required this.description,
    required this.previewUrl,
    required this.isCompleted,
  });
}

final class _LessonCompleted extends AudioPageEvent {
  final LoopMode loopMode;

  const _LessonCompleted(this.loopMode);
}
