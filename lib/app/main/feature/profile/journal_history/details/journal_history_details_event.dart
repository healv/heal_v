part of 'journal_history_details_bloc.dart';

sealed class JournalHistoryDetailsEvent extends BaseEvent {
  JournalHistoryDetailsEvent();

  factory JournalHistoryDetailsEvent.initial(DailyProgressDto progressItem) => Initial._(progressItem: progressItem);

  factory JournalHistoryDetailsEvent.deleteJournal(String date) => DeleteJournal._(date: date);
}

final class Initial extends JournalHistoryDetailsEvent {
  final DailyProgressDto progressItem;

  Initial._({required this.progressItem});
}

final class DeleteJournal extends JournalHistoryDetailsEvent {
  final String date;

  DeleteJournal._({required this.date});
}
