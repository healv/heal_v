part of 'put_journal_bloc.dart';

@immutable
final class PutJournalState extends BaseState {
  final bool? loading;
  final String? message;
  final String? messageErrorMsg;

  const PutJournalState._({
    this.loading,
    this.message,
    this.messageErrorMsg,
  });

  factory PutJournalState.initial() => const PutJournalState._();

  @override
  List<Object?> get props => [loading, message, messageErrorMsg];

  PutJournalState copyWith({
    Optional<bool?>? loading,
    Optional<String?>? message,
    Optional<String?>? messageErrorMsg,
  }) {
    return PutJournalState._(
      loading: loading?.isValid == true ? loading?.value : this.loading,
      message: message?.isValid == true ? message?.value : this.message,
      messageErrorMsg: messageErrorMsg?.isValid == true ? messageErrorMsg?.value : this.messageErrorMsg,
    );
  }
}
