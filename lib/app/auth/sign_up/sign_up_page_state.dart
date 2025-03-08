part of 'sign_up_page_bloc.dart';

@immutable
class SignUpPageState extends BaseState {
  final String? firstName;
  final String? email;
  final String? password;
  final String? repeatPassword;
  final String? firstNameErrorMsg;
  final String? lastNameErrorMsg;
  final String? emailErrorMsg;
  final String? passwordErrorMsg;
  final String? repeatPasswordErrorMsg;
  final bool isPasswordHidden;
  final bool isRepeatPasswordHidden;

  const SignUpPageState._({
    this.firstName,
    this.email,
    this.password,
    this.repeatPassword,
    this.firstNameErrorMsg,
    this.lastNameErrorMsg,
    this.emailErrorMsg,
    this.passwordErrorMsg,
    this.repeatPasswordErrorMsg,
    this.isPasswordHidden = true,
    this.isRepeatPasswordHidden = true,
  });

  factory SignUpPageState.initial() => const SignUpPageState._();

  @override
  List<Object?> get props => [
        firstName,
        email,
        password,
        repeatPassword,
        firstNameErrorMsg,
        lastNameErrorMsg,
        emailErrorMsg,
        passwordErrorMsg,
        repeatPasswordErrorMsg,
        isPasswordHidden,
        isRepeatPasswordHidden,
      ];

  SignUpPageState copyWith({
    Optional<String?>? firstName,
    Optional<String?>? email,
    Optional<String?>? password,
    Optional<String?>? repeatPassword,
    Optional<String?>? firstNameErrorMsg,
    Optional<String?>? lastNameErrorMsg,
    Optional<String?>? emailErrorMsg,
    Optional<String?>? passwordErrorMsg,
    Optional<String?>? repeatPasswordErrorMsg,
    bool? isPasswordHidden,
    bool? isRepeatPasswordHidden,
  }) {
    return SignUpPageState._(
      firstName: firstName?.isValid == true ? firstName?.value : this.firstName,
      email: email?.isValid == true ? email?.value : this.email,
      password: password?.isValid == true ? password?.value : this.password,
      repeatPassword: repeatPassword?.isValid == true ? repeatPassword?.value : this.repeatPassword,
      firstNameErrorMsg: firstNameErrorMsg?.isValid == true ? firstNameErrorMsg?.value : this.firstNameErrorMsg,
      lastNameErrorMsg: lastNameErrorMsg?.isValid == true ? lastNameErrorMsg?.value : this.lastNameErrorMsg,
      emailErrorMsg: emailErrorMsg?.isValid == true ? emailErrorMsg?.value : this.emailErrorMsg,
      passwordErrorMsg: passwordErrorMsg?.isValid == true ? passwordErrorMsg?.value : this.passwordErrorMsg,
      repeatPasswordErrorMsg: repeatPasswordErrorMsg?.isValid == true ? repeatPasswordErrorMsg?.value : this.repeatPasswordErrorMsg,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
      isRepeatPasswordHidden: isRepeatPasswordHidden ?? this.isRepeatPasswordHidden,
    );
  }
}
