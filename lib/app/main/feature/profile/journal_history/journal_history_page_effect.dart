part of 'journal_history_page_bloc.dart';

sealed class JournalHistoryPageEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  const JournalHistoryPageEffect(this.status, {this.errorMsg});
}
