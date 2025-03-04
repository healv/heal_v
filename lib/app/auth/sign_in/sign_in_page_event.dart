part of 'sign_in_page_bloc.dart';

sealed class SignInPageEvent extends BaseEvent {
  const SignInPageEvent();

  factory SignInPageEvent.emailChanged({required String email}) => EmailChanged._(email: email);

  factory SignInPageEvent.passwordChanged({required String password}) => PasswordChanged._(password: password);

  factory SignInPageEvent.emailFocusChanged({required bool isFocused}) => EmailFocusChanged._(isFocused: isFocused);

  factory SignInPageEvent.passwordFocusChanged({required bool isFocused}) => PasswordFocusChanged._(isFocused: isFocused);

  factory SignInPageEvent.validateEmail() => const ValidateEmail._();

  factory SignInPageEvent.validatePassword() => const ValidatePassword._();
}

final class EmailChanged extends SignInPageEvent {
  final String? email;

  const EmailChanged._({required this.email});
}

final class PasswordChanged extends SignInPageEvent {
  final String? password;

  const PasswordChanged._({required this.password});
}

final class EmailFocusChanged extends SignInPageEvent {
  final bool isFocused;

  const EmailFocusChanged._({required this.isFocused});
}

final class PasswordFocusChanged extends SignInPageEvent {
  final bool isFocused;

  const PasswordFocusChanged._({required this.isFocused});
}

final class ValidateEmail extends SignInPageEvent {
  const ValidateEmail._();
}

final class ValidatePassword extends SignInPageEvent {
  const ValidatePassword._();
}
