part of 'stretching_details_page_bloc.dart';

@immutable
final class StretchingDetailsPageState extends BaseState {
  final StretchingLesson? stretchingLesson;
  final String? weekTitle;
  final String? weekId;

  const StretchingDetailsPageState._({
    this.stretchingLesson,
    this.weekTitle,
    this.weekId,
  });

  factory StretchingDetailsPageState.initial() => const StretchingDetailsPageState._();

  @override
  List<Object?> get props => [stretchingLesson, weekTitle, weekId];

  StretchingDetailsPageState copyWith({
    Optional<StretchingLesson?>? stretchingLesson,
    Optional<String?>? weekTitle,
    Optional<String?>? weekId,
  }) {
    return StretchingDetailsPageState._(
      stretchingLesson: stretchingLesson?.isValid == true ? stretchingLesson?.value : this.stretchingLesson,
      weekTitle: weekTitle?.isValid == true ? weekTitle?.value : this.weekTitle,
      weekId: weekId?.isValid == true ? weekId?.value : this.weekId,
    );
  }
}
