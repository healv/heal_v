part of 'put_journal_bloc.dart';

sealed class PutJournalEvent extends BaseEvent {
  PutJournalEvent();

  factory PutJournalEvent.initial() => Initial._();

  factory PutJournalEvent.messageChanged(String message) => MessageChanged._(message: message);

  factory PutJournalEvent.putJournal(String message) => PutJournal._(message: message);
}

final class Initial extends PutJournalEvent {
  Initial._();
}

final class MessageChanged extends PutJournalEvent {
  final String message;

  MessageChanged._({required this.message});
}

final class PutJournal extends PutJournalEvent {
  final String message;

  PutJournal._({required this.message});
}
