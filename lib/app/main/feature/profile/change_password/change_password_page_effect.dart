part of 'change_password_page_bloc.dart';

sealed class ChangePasswordPageSideEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  const ChangePasswordPageSideEffect(this.status, {this.errorMsg});

  factory ChangePasswordPageSideEffect.validated(
    ResourceStatusEnum status, {
    String? currentPassword,
    String? newPassword,
    String? errorMsg,
  }) =>
      Validated(
        status,
        currentPassword: currentPassword,
        newPassword: newPassword,
        errorMsg: errorMsg,
      );
}

final class Validated extends ChangePasswordPageSideEffect {
  final String? currentPassword;
  final String? newPassword;

  Validated(super.status, {this.currentPassword, this.newPassword, super.errorMsg});
}
