part of 'forgot_password_page_bloc.dart';

@immutable
class ForgotPasswordPageState extends BaseState {
  final String? email;
  final String? emailErrorMsg;
  final bool isLoading;

  const ForgotPasswordPageState._({
    this.email,
    this.emailErrorMsg,
    this.isLoading = false,
  });

  factory ForgotPasswordPageState.initial() => const ForgotPasswordPageState._();

  @override
  List<Object?> get props => [email, emailErrorMsg, isLoading];

  ForgotPasswordPageState copyWith({
    Optional<String?>? email,
    Optional<String?>? emailErrorMsg,
    bool? isLoading,
  }) {
    return ForgotPasswordPageState._(
      email: email?.isValid == true ? email?.value : this.email,
      emailErrorMsg: emailErrorMsg?.isValid == true ? emailErrorMsg?.value : this.emailErrorMsg,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
