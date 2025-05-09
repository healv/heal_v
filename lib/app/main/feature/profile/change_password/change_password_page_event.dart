part of 'change_password_page_bloc.dart';

abstract class ChangePasswordPageEvent extends BaseEvent {
  const ChangePasswordPageEvent();

  factory ChangePasswordPageEvent.initial() => const Initial._();

  factory ChangePasswordPageEvent.currentPasswordChanged(String password) => CurrentPasswordChanged._(password: password);

  factory ChangePasswordPageEvent.newPasswordChanged(String password) => NewPasswordChanged._(password: password);

  factory ChangePasswordPageEvent.confirmNewPasswordChanged(String password) => ConfirmNewPasswordChanged._(password: password);

  factory ChangePasswordPageEvent.validatePasswordsMatch(
    String? newPassword,
    String? confirmNewPassword,
  ) =>
      ValidatePasswordsMatch._(
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );

  factory ChangePasswordPageEvent.validate(
    String? currentPassword,
    String? newPassword,
    String? confirmNewPassword,
  ) =>
      Validate._(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );

  factory ChangePasswordPageEvent.currentPasswordVisibilityChanged() => const CurrentPasswordVisibilityChanged._();

  factory ChangePasswordPageEvent.newPasswordVisibilityChanged() => const NewPasswordVisibilityChanged._();

  factory ChangePasswordPageEvent.confirmNewPasswordVisibilityChanged() => const ConfirmNewPasswordVisibilityChanged._();

  factory ChangePasswordPageEvent.currentPasswordErrorMsgChanged(String errorMessage) => CurrentPasswordErrorMsgChanged._(errorMessage: errorMessage);

  factory ChangePasswordPageEvent.loadingStateChanged(bool isLoading) => LoadingStateChanged._(isLoading: isLoading);
}

final class Initial extends ChangePasswordPageEvent {
  const Initial._();
}

final class CurrentPasswordChanged extends ChangePasswordPageEvent {
  final String password;

  const CurrentPasswordChanged._({required this.password});
}

final class CurrentPasswordVisibilityChanged extends ChangePasswordPageEvent {
  const CurrentPasswordVisibilityChanged._();
}

final class NewPasswordChanged extends ChangePasswordPageEvent {
  final String password;

  const NewPasswordChanged._({required this.password});
}

final class NewPasswordVisibilityChanged extends ChangePasswordPageEvent {
  const NewPasswordVisibilityChanged._();
}

final class ConfirmNewPasswordChanged extends ChangePasswordPageEvent {
  final String password;

  const ConfirmNewPasswordChanged._({required this.password});
}

final class ConfirmNewPasswordVisibilityChanged extends ChangePasswordPageEvent {
  const ConfirmNewPasswordVisibilityChanged._();
}

final class ValidatePasswordsMatch extends ChangePasswordPageEvent {
  final String? newPassword;
  final String? confirmNewPassword;

  const ValidatePasswordsMatch._({required this.newPassword, required this.confirmNewPassword});
}

final class Validate extends ChangePasswordPageEvent {
  final String? currentPassword;
  final String? newPassword;
  final String? confirmNewPassword;

  const Validate._({required this.currentPassword, required this.newPassword, required this.confirmNewPassword});
}

final class CurrentPasswordErrorMsgChanged extends ChangePasswordPageEvent {
  final String errorMessage;

  const CurrentPasswordErrorMsgChanged._({required this.errorMessage});
}

final class LoadingStateChanged extends ChangePasswordPageEvent {
  final bool isLoading;

  const LoadingStateChanged._({required this.isLoading});
}
