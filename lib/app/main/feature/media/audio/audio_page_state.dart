part of 'audio_page_bloc.dart';

@immutable
class AudioPageState extends BaseState {
  final LessonTypeEnum? lessonTypeEnum;
  final String? id;
  final String? weekId;
  final String? title;
  final String? description;
  final String? previewUrl;
  final bool? isCompleted;

  const AudioPageState._({
    this.lessonTypeEnum,
    this.id,
    this.weekId,
    this.title,
    this.description,
    this.previewUrl,
    this.isCompleted,
  });

  factory AudioPageState.initial() => const AudioPageState._();

  @override
  List<Object?> get props => [lessonTypeEnum, id, weekId, title, description, previewUrl, isCompleted];

  AudioPageState copyWith({
    Optional<LessonTypeEnum?>? lessonTypeEnum,
    Optional<String?>? id,
    Optional<String?>? weekId,
    Optional<String?>? title,
    Optional<String?>? description,
    Optional<String?>? previewUrl,
    Optional<bool?>? isCompleted,
  }) {
    return AudioPageState._(
      lessonTypeEnum: lessonTypeEnum?.isValid == true ? lessonTypeEnum?.value : this.lessonTypeEnum,
      id: id?.isValid == true ? id?.value : this.id,
      weekId: weekId?.isValid == true ? weekId?.value : this.weekId,
      title: title?.isValid == true ? title?.value : this.title,
      description: description?.isValid == true ? description?.value : this.description,
      previewUrl: previewUrl?.isValid == true ? previewUrl?.value : this.previewUrl,
      isCompleted: isCompleted?.isValid == true ? isCompleted?.value : this.isCompleted,
    );
  }
}
