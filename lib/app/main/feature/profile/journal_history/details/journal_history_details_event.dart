part of 'journal_history_details_bloc.dart';

sealed class JournalHistoryDetailsEvent extends BaseEvent {
  JournalHistoryDetailsEvent();

  factory JournalHistoryDetailsEvent.initial(JournalHistoryDto journalHistoryItem) => Initial._(journalHistoryItem: journalHistoryItem);

  factory JournalHistoryDetailsEvent.deleteJournal(String date) => DeleteJournal._(date: date);
}

final class Initial extends JournalHistoryDetailsEvent {
  final JournalHistoryDto journalHistoryItem;

  Initial._({required this.journalHistoryItem});
}

final class DeleteJournal extends JournalHistoryDetailsEvent {
  final String date;

  DeleteJournal._({required this.date});
}
