part of 'sign_up_page_bloc.dart';

sealed class SignUpPageEvent extends BaseEvent {
  const SignUpPageEvent();

  factory SignUpPageEvent.firstNameChanged({required String firstName}) => FirstNameChanged._(firstName: firstName);

  factory SignUpPageEvent.lastNameChanged({required String lastName}) => LastNameChanged._(lastName: lastName);

  factory SignUpPageEvent.emailChanged({required String email}) => EmailChanged._(email: email);

  factory SignUpPageEvent.passwordChanged({required String password}) => PasswordChanged._(password: password);

  factory SignUpPageEvent.repeatPasswordChanged({required String password}) => RepeatPasswordChanged._(password: password);

  factory SignUpPageEvent.validate() => const Validate._();
}

final class FirstNameChanged extends SignUpPageEvent {
  final String? firstName;

  const FirstNameChanged._({required this.firstName});
}

final class LastNameChanged extends SignUpPageEvent {
  final String? lastName;

  const LastNameChanged._({required this.lastName});
}

final class EmailChanged extends SignUpPageEvent {
  final String? email;

  const EmailChanged._({required this.email});
}

final class PasswordChanged extends SignUpPageEvent {
  final String? password;

  const PasswordChanged._({required this.password});
}

final class RepeatPasswordChanged extends SignUpPageEvent {
  final String? password;

  const RepeatPasswordChanged._({required this.password});
}

final class Validate extends SignUpPageEvent {
  const Validate._();
}
