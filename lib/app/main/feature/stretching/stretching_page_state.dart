part of 'stretching_page_bloc.dart';

@immutable
final class StretchingPageState extends BaseState {
  final List<StretchingWeek>? weeks;
  final StretchingLessons? stretchingLessons;
  final bool? weeksLoading;
  final bool? lessonsLoading;
  final String? selectedWeekId;

  const StretchingPageState._({
    this.weeks,
    this.stretchingLessons,
    this.weeksLoading,
    this.lessonsLoading,
    this.selectedWeekId,
  });

  factory StretchingPageState.initial() => const StretchingPageState._();

  @override
  List<Object?> get props => [weeks, stretchingLessons, weeksLoading, lessonsLoading, selectedWeekId];

  StretchingPageState copyWith({
    Optional<List<StretchingWeek>?>? weeks,
    Optional<StretchingLessons?>? stretchingLessons,
    Optional<bool?>? weeksLoading,
    Optional<bool?>? lessonsLoading,
    Optional<String?>? selectedWeekId,
  }) {
    return StretchingPageState._(
      weeks: weeks?.isValid == true ? weeks?.value : this.weeks,
      stretchingLessons: stretchingLessons?.isValid == true ? stretchingLessons?.value : this.stretchingLessons,
      weeksLoading: weeksLoading?.isValid == true ? weeksLoading?.value : this.weeksLoading,
      lessonsLoading: lessonsLoading?.isValid == true ? lessonsLoading?.value : this.lessonsLoading,
      selectedWeekId: selectedWeekId?.isValid == true ? selectedWeekId?.value : this.selectedWeekId,
    );
  }
}
