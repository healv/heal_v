part of 'journal_history_details_bloc.dart';

sealed class JournalHistoryDetailsEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  const JournalHistoryDetailsEffect(this.status, {this.errorMsg});

  factory JournalHistoryDetailsEffect.journalDeleted(ResourceStatusEnum status, {String? errorMsg}) => JournalDeleted(status, errorMsg: errorMsg);
}

final class JournalDeleted extends JournalHistoryDetailsEffect {
  JournalDeleted(super.status, {super.errorMsg});
}
