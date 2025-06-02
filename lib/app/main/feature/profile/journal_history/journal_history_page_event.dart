part of 'journal_history_page_bloc.dart';

sealed class JournalHistoryPageEvent extends BaseEvent {
  JournalHistoryPageEvent();

  factory JournalHistoryPageEvent.initial() => Initial._();

  factory JournalHistoryPageEvent.journalHistory({int? page}) => GetJournalHistory._(page: page);

  factory JournalHistoryPageEvent.deleteJournal({String? date}) => DeleteJournal._(date: date);
}

final class Initial extends JournalHistoryPageEvent {
  Initial._();
}

final class GetJournalHistory extends JournalHistoryPageEvent {
  final int? page;

  GetJournalHistory._({this.page});
}

final class DeleteJournal extends JournalHistoryPageEvent {
  final String? date;

  DeleteJournal._({this.date});
}
