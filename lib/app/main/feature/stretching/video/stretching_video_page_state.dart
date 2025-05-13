part of 'stretching_video_page_bloc.dart';

@immutable
class StretchingVideoPageState extends BaseState {
  final StretchingLesson? stretchingLesson;

  const StretchingVideoPageState._({
    this.stretchingLesson,
  });

  factory StretchingVideoPageState.initial() => const StretchingVideoPageState._();

  @override
  List<Object?> get props => [stretchingLesson];

  StretchingVideoPageState copyWith({
    Optional<StretchingLesson?>? stretchingLesson,
  }) {
    return StretchingVideoPageState._(
      stretchingLesson: stretchingLesson?.isValid == true ? stretchingLesson?.value : this.stretchingLesson,
    );
  }
}
