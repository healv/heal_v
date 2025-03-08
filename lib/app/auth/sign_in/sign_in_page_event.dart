part of 'sign_in_page_bloc.dart';

sealed class SignInPageEvent extends BaseEvent {
  const SignInPageEvent();

  factory SignInPageEvent.emailChanged({required String email}) => EmailChanged._(email: email);

  factory SignInPageEvent.passwordChanged({required String password}) => PasswordChanged._(password: password);

  factory SignInPageEvent.validate() => const Validate._();

  factory SignInPageEvent.updatePasswordVisibility() => const UpdatePasswordVisibility._();
}

final class EmailChanged extends SignInPageEvent {
  final String? email;

  const EmailChanged._({required this.email});
}

final class PasswordChanged extends SignInPageEvent {
  final String? password;

  const PasswordChanged._({required this.password});
}

final class Validate extends SignInPageEvent {
  const Validate._();
}

final class UpdatePasswordVisibility extends SignInPageEvent {
  const UpdatePasswordVisibility._();
}