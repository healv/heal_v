part of 'forgot_password_page_bloc.dart';

abstract class ForgotPasswordPageEvent extends BaseEvent {
  const ForgotPasswordPageEvent();

  factory ForgotPasswordPageEvent.initial() => const Initial._();

  factory ForgotPasswordPageEvent.emailChanged(String email) => EmailChanged._(email: email);

  factory ForgotPasswordPageEvent.validate(String? email) => Validate._(email: email);

  factory ForgotPasswordPageEvent.emailErrorMsgChanged(String errorMessage) => EmailErrorMsgChanged._(errorMessage: errorMessage);

  factory ForgotPasswordPageEvent.loadingStateChanged(bool isLoading) => LoadingStateChanged._(isLoading: isLoading);
}

final class Initial extends ForgotPasswordPageEvent {
  const Initial._();
}

final class EmailChanged extends ForgotPasswordPageEvent {
  final String email;

  const EmailChanged._({required this.email});
}

final class Validate extends ForgotPasswordPageEvent {
  final String? email;

  const Validate._({required this.email});
}

final class EmailErrorMsgChanged extends ForgotPasswordPageEvent {
  final String errorMessage;

  const EmailErrorMsgChanged._({required this.errorMessage});
}

final class LoadingStateChanged extends ForgotPasswordPageEvent {
  final bool isLoading;

  const LoadingStateChanged._({required this.isLoading});
}
