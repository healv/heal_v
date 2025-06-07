part of 'progress_page_bloc.dart';

@immutable
final class ProgressPageState extends BaseState {
  final DateTime? currentMonth;
  final bool? totalProgressLoading;
  final bool? progressListLoading;
  final TotalProgressDto? totalProgress;
  final DailyProgressListDto? progressList;

  const ProgressPageState._({
    this.currentMonth,
    this.totalProgressLoading,
    this.progressListLoading,
    this.totalProgress,
    this.progressList,
  });

  factory ProgressPageState.initial() => const ProgressPageState._();

  @override
  List<Object?> get props => [currentMonth, totalProgressLoading, progressListLoading, totalProgress, progressList];

  ProgressPageState copyWith({
    Optional<DateTime?>? currentMonth,
    Optional<bool?>? totalProgressLoading,
    Optional<bool?>? progressListLoading,
    Optional<TotalProgressDto?>? totalProgress,
    Optional<DailyProgressListDto?>? progressList,
  }) {
    return ProgressPageState._(
      currentMonth: currentMonth?.isValid == true ? currentMonth?.value : this.currentMonth,
      totalProgressLoading: totalProgressLoading?.isValid == true ? totalProgressLoading?.value : this.totalProgressLoading,
      progressListLoading: progressListLoading?.isValid == true ? progressListLoading?.value : this.progressListLoading,
      totalProgress: totalProgress?.isValid == true ? totalProgress?.value : this.totalProgress,
      progressList: progressList?.isValid == true ? progressList?.value : this.progressList,
    );
  }
}
