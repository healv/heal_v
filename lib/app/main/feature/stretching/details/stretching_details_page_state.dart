part of 'stretching_details_page_bloc.dart';

@immutable
final class StretchingDetailsPageState extends BaseState {
  final StretchingLesson? stretchingLesson;
  final String ? weekTitle;

  const StretchingDetailsPageState._({
    this.stretchingLesson,
    this.weekTitle,
  });

  factory StretchingDetailsPageState.initial() => const StretchingDetailsPageState._();

  @override
  List<Object?> get props => [stretchingLesson,weekTitle];

  StretchingDetailsPageState copyWith({
    Optional<StretchingLesson?>? stretchingLesson,
    Optional<String?>? weekTitle,
  }) {
    return StretchingDetailsPageState._(
      stretchingLesson: stretchingLesson?.isValid == true ? stretchingLesson?.value : this.stretchingLesson,
      weekTitle: weekTitle?.isValid == true ? weekTitle?.value : this.weekTitle,
    );
  }
}
