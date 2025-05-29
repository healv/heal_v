part of 'put_journal_bloc.dart';

sealed class PutJournalEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  const PutJournalEffect(this.status, {this.errorMsg});

  factory PutJournalEffect.validated(ResourceStatusEnum status, {String? errorMsg, String? message}) => Validated(status, errorMsg: errorMsg, message: message);
}

final class Validated extends PutJournalEffect {
  final String? message;

  Validated(super.status, {super.errorMsg, this.message});
}
