part of 'put_journal_bloc.dart';

sealed class PutJournalEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  const PutJournalEffect(this.status, {this.errorMsg});

  factory PutJournalEffect.journalPut(ResourceStatusEnum status, {String? errorMsg}) => JournalPut(status, errorMsg: errorMsg);
}

final class JournalPut extends PutJournalEffect {
  JournalPut(super.status, {super.errorMsg});
}
