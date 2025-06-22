part of 'stretching_video_page_bloc.dart';

@immutable
class StretchingVideoPageState extends BaseState {
  final StretchingLesson? stretchingLesson;
  final String? weekId;

  const StretchingVideoPageState._({
    this.stretchingLesson,
    this.weekId,
  });

  factory StretchingVideoPageState.initial() => const StretchingVideoPageState._();

  @override
  List<Object?> get props => [stretchingLesson, weekId];

  StretchingVideoPageState copyWith({
    Optional<StretchingLesson?>? stretchingLesson,
    Optional<String?>? weekId,
  }) {
    return StretchingVideoPageState._(
      stretchingLesson: stretchingLesson?.isValid == true ? stretchingLesson?.value : this.stretchingLesson,
      weekId: weekId?.isValid == true ? weekId?.value : this.weekId,
    );
  }
}
