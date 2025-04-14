part of 'journal_history_page_bloc.dart';

sealed class JournalHistoryPageEvent extends BaseEvent {
  JournalHistoryPageEvent();

  factory JournalHistoryPageEvent.initial() => Initial._();

  factory JournalHistoryPageEvent.journalHistory() => GetJournalHistory._();
}

final class Initial extends JournalHistoryPageEvent {
  Initial._();
}

final class GetJournalHistory extends JournalHistoryPageEvent {
  GetJournalHistory._();
}
