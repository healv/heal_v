part of 'breathing_page_bloc.dart';

@immutable
final class BreathingPageState extends BaseState {
  final List<BreathingWeek>? weeks;
  final BreathingLessons? breathingLessons;
  final bool? weeksLoading;
  final bool? lessonsLoading;
  final String? selectedWeekId;

  const BreathingPageState._({
    this.weeks,
    this.breathingLessons,
    this.weeksLoading,
    this.lessonsLoading,
    this.selectedWeekId,
  });

  factory BreathingPageState.initial() => const BreathingPageState._();

  @override
  List<Object?> get props => [weeks, breathingLessons, weeksLoading, lessonsLoading, selectedWeekId];

  BreathingPageState copyWith({
    Optional<List<BreathingWeek>?>? weeks,
    Optional<BreathingLessons?>? breathingLessons,
    Optional<bool?>? weeksLoading,
    Optional<bool?>? lessonsLoading,
    Optional<String?>? selectedWeekId,
  }) {
    return BreathingPageState._(
      weeks: weeks?.isValid == true ? weeks?.value : this.weeks,
      breathingLessons: breathingLessons?.isValid == true ? breathingLessons?.value : this.breathingLessons,
      weeksLoading: weeksLoading?.isValid == true ? weeksLoading?.value : this.weeksLoading,
      lessonsLoading: lessonsLoading?.isValid == true ? lessonsLoading?.value : this.lessonsLoading,
      selectedWeekId: selectedWeekId?.isValid == true ? selectedWeekId?.value : this.selectedWeekId,
    );
  }
}
