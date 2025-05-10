part of 'journal_history_details_bloc.dart';

@immutable
final class JournalHistoryDetailsState extends BaseState {
  final bool? loading;
  final JournalHistoryDto? journalHistoryItem;

  const JournalHistoryDetailsState._({
    this.loading,
    this.journalHistoryItem,
  });

  factory JournalHistoryDetailsState.initial() => const JournalHistoryDetailsState._();

  @override
  List<Object?> get props => [loading, journalHistoryItem];

  JournalHistoryDetailsState copyWith({
    Optional<bool?>? loading,
    Optional<JournalHistoryDto?>? journalHistoryItem,
  }) {
    return JournalHistoryDetailsState._(
      loading: loading?.isValid == true ? loading?.value : this.loading,
      journalHistoryItem: journalHistoryItem?.isValid == true ? journalHistoryItem?.value : this.journalHistoryItem,
    );
  }
}
