part of 'journal_history_page_bloc.dart';

@immutable
final class JournalHistoryPageState extends BaseState {
  final List<DailyProgressDto>? journalHistory;
  final Map<String, List<DailyProgressDto>>? grouped;
  final int? pageNumber;
  final bool? loading;
  final bool? isLastPage;

  const JournalHistoryPageState._({
    this.journalHistory,
    this.grouped,
    this.pageNumber,
    this.loading,
    this.isLastPage,
  });

  factory JournalHistoryPageState.initial() => const JournalHistoryPageState._();

  @override
  List<Object?> get props => [journalHistory, grouped, pageNumber, loading];

  JournalHistoryPageState copyWith({
    Optional<List<DailyProgressDto>?>? journalHistory,
    Optional<Map<String, List<DailyProgressDto>>>? grouped,
    Optional<int?>? pageNumber,
    Optional<bool?>? loading,
    Optional<bool?>? isLastPage,
  }) {
    return JournalHistoryPageState._(
      journalHistory: journalHistory?.isValid == true ? journalHistory?.value : this.journalHistory,
      grouped: grouped?.isValid == true ? grouped?.value : this.grouped,
      pageNumber: pageNumber?.isValid == true ? pageNumber?.value : this.pageNumber,
      loading: loading?.isValid == true ? loading?.value : this.loading,
      isLastPage: isLastPage?.isValid == true ? isLastPage?.value : this.isLastPage,
    );
  }
}
