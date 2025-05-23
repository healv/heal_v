part of 'meditation_page_bloc.dart';

@immutable
final class MeditationPageState extends BaseState {
  final List<MeditationWeek>? weeks;
  final MeditationLessons? meditationLessons;
  final bool? weeksLoading;
  final bool? lessonsLoading;
  final String? selectedWeekId;

  const MeditationPageState._({
    this.weeks,
    this.meditationLessons,
    this.weeksLoading,
    this.lessonsLoading,
    this.selectedWeekId,
  });

  factory MeditationPageState.initial() => const MeditationPageState._();

  @override
  List<Object?> get props => [
        weeks,
        meditationLessons,
        weeksLoading,
        lessonsLoading,
        selectedWeekId,
      ];

  MeditationPageState copyWith({
    Optional<List<MeditationWeek>?>? weeks,
    Optional<MeditationLessons?>? meditationLessons,
    Optional<bool?>? weeksLoading,
    Optional<bool?>? lessonsLoading,
    Optional<String?>? selectedWeekId,
  }) {
    return MeditationPageState._(
      weeks: weeks?.isValid == true ? weeks?.value : this.weeks,
      meditationLessons: meditationLessons?.isValid == true ? meditationLessons?.value : this.meditationLessons,
      weeksLoading: weeksLoading?.isValid == true ? weeksLoading?.value : this.weeksLoading,
      lessonsLoading: lessonsLoading?.isValid == true ? lessonsLoading?.value : this.lessonsLoading,
      selectedWeekId: selectedWeekId?.isValid == true ? selectedWeekId?.value : this.selectedWeekId,
    );
  }
}
