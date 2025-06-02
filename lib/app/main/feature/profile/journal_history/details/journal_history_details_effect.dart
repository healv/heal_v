part of 'journal_history_details_bloc.dart';

sealed class JournalHistoryDetailsEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  const JournalHistoryDetailsEffect(this.status, {this.errorMsg});

  factory JournalHistoryDetailsEffect.journalDeleted(
    ResourceStatusEnum status, {
    String? errorMsg,
    String? date,
  }) =>
      JournalDeleted(status, errorMsg: errorMsg, date: date);
}

final class JournalDeleted extends JournalHistoryDetailsEffect {
  final String? date;

  JournalDeleted(super.status, {super.errorMsg, this.date});
}
