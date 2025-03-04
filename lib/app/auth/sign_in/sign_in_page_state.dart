part of 'sign_in_page_bloc.dart';

@immutable
class SignInPageState extends BaseState {
  final String? email;
  final String? password;
  final String? emailErrorMsg;
  final String? passwordErrorMsg;
  final bool isEmailFocused;
  final bool isPasswordFocused;

  const SignInPageState._({
    this.email,
    this.password,
    this.emailErrorMsg,
    this.passwordErrorMsg,
    this.isEmailFocused = false,
    this.isPasswordFocused = false,
  });

  factory SignInPageState.initial() => const SignInPageState._();

  @override
  List<Object?> get props => [email, password, emailErrorMsg, passwordErrorMsg, isEmailFocused, isPasswordFocused];

  SignInPageState copyWith({
    Optional<String?>? email,
    Optional<String?>? password,
    Optional<String?>? emailErrorMsg,
    Optional<String?>? passwordErrorMsg,
    bool? isEmailFocused,
    bool? isPasswordFocused,
  }) {
    return SignInPageState._(
      email: email?.isValid == true ? email?.value : this.email,
      password: password?.isValid == true ? password?.value : this.password,
      emailErrorMsg: emailErrorMsg?.isValid == true ? emailErrorMsg?.value : this.emailErrorMsg,
      passwordErrorMsg: passwordErrorMsg?.isValid == true ? passwordErrorMsg?.value : this.passwordErrorMsg,
      isEmailFocused: isEmailFocused ?? this.isEmailFocused,
      isPasswordFocused: isPasswordFocused ?? this.isPasswordFocused,
    );
  }
}
