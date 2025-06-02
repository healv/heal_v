part of 'journal_history_details_bloc.dart';

@immutable
final class JournalHistoryDetailsState extends BaseState {
  final bool? loading;
  final DailyProgressDto? progressItem;

  const JournalHistoryDetailsState._({
    this.loading,
    this.progressItem,
  });

  factory JournalHistoryDetailsState.initial() => const JournalHistoryDetailsState._();

  @override
  List<Object?> get props => [loading, progressItem];

  JournalHistoryDetailsState copyWith({
    Optional<bool?>? loading,
    Optional<DailyProgressDto?>? progressItem,
  }) {
    return JournalHistoryDetailsState._(
      loading: loading?.isValid == true ? loading?.value : this.loading,
      progressItem: progressItem?.isValid == true ? progressItem?.value : this.progressItem,
    );
  }
}
