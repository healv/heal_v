part of 'shared_content_bloc.dart';

@immutable
final class SharedContentState extends BaseState {
  final String? appBarMessage;
  final bool loading;

  const SharedContentState._({
    this.appBarMessage,
    this.loading = false,
  });

  factory SharedContentState.initial() => const SharedContentState._();

  @override
  List<Object?> get props => [appBarMessage, loading];

  SharedContentState copyWith({
    Optional<String?>? appBarMessage,
    Optional<bool?>? loading,
  }) {
    return SharedContentState._(
      appBarMessage: appBarMessage?.isValid == true ? appBarMessage?.value : this.appBarMessage,
      loading: loading?.isValid == true ? loading?.value ?? false : this.loading,
    );
  }
}
