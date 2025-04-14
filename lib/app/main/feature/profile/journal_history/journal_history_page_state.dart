part of 'journal_history_page_bloc.dart';

@immutable
final class JournalHistoryPageState extends BaseState {
  final List<JournalHistoryDto>? journalHistory;
  final Map<String, List<JournalHistoryDto>>? grouped;
  final bool? loading;

  const JournalHistoryPageState._({
    this.journalHistory,
    this.grouped,
    this.loading,
  });

  factory JournalHistoryPageState.initial() => const JournalHistoryPageState._();

  @override
  List<Object?> get props => [journalHistory, grouped, loading];

  JournalHistoryPageState copyWith({
    Optional<List<JournalHistoryDto>?>? journalHistory,
    Optional<Map<String, List<JournalHistoryDto>>>? grouped,
    Optional<bool?>? loading,
  }) {
    return JournalHistoryPageState._(
      journalHistory: journalHistory?.isValid == true ? journalHistory?.value : this.journalHistory,
      grouped: grouped?.isValid == true ? grouped?.value : this.grouped,
      loading: loading?.isValid == true ? loading?.value : this.loading,
    );
  }
}
