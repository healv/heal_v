part of 'change_password_page_bloc.dart';

@immutable
class ChangePasswordPageState extends BaseState {
  final String? currentPassword;
  final String? newPassword;
  final String? confirmNewPassword;
  final String? currentPasswordErrorMsg;
  final String? newPasswordErrorMsg;
  final String? confirmNewPasswordErrorMsg;
  final bool isCurrentPasswordHidden;
  final bool isNewPasswordHidden;
  final bool isConfirmNewPasswordHidden;
  final bool isLoading;

  const ChangePasswordPageState._({
    this.currentPassword,
    this.newPassword,
    this.confirmNewPassword,
    this.currentPasswordErrorMsg,
    this.newPasswordErrorMsg,
    this.confirmNewPasswordErrorMsg,
    this.isCurrentPasswordHidden = true,
    this.isNewPasswordHidden = true,
    this.isConfirmNewPasswordHidden = true,
    this.isLoading = false,
  });

  factory ChangePasswordPageState.initial() => const ChangePasswordPageState._();

  @override
  List<Object?> get props => [
        currentPassword,
        newPassword,
        confirmNewPassword,
        currentPasswordErrorMsg,
        newPasswordErrorMsg,
        confirmNewPasswordErrorMsg,
        isCurrentPasswordHidden,
        isNewPasswordHidden,
        isConfirmNewPasswordHidden,
        isLoading,
      ];

  ChangePasswordPageState copyWith({
    Optional<String?>? currentPassword,
    Optional<String?>? newPassword,
    Optional<String?>? confirmNewPassword,
    Optional<String?>? currentPasswordErrorMsg,
    Optional<String?>? newPasswordErrorMsg,
    Optional<String?>? confirmNewPasswordErrorMsg,
    bool? isCurrentPasswordHidden,
    bool? isNewPasswordHidden,
    bool? isConfirmNewPasswordHidden,
    bool? isLoading,
  }) {
    return ChangePasswordPageState._(
      currentPassword: currentPassword?.isValid == true ? currentPassword?.value : this.currentPassword,
      newPassword: newPassword?.isValid == true ? newPassword?.value : this.newPassword,
      confirmNewPassword: confirmNewPassword?.isValid == true ? confirmNewPassword?.value : this.confirmNewPassword,
      currentPasswordErrorMsg: currentPasswordErrorMsg?.isValid == true ? currentPasswordErrorMsg?.value : this.currentPasswordErrorMsg,
      newPasswordErrorMsg: newPasswordErrorMsg?.isValid == true ? newPasswordErrorMsg?.value : this.newPasswordErrorMsg,
      confirmNewPasswordErrorMsg: confirmNewPasswordErrorMsg?.isValid == true ? confirmNewPasswordErrorMsg?.value : this.confirmNewPasswordErrorMsg,
      isCurrentPasswordHidden: isCurrentPasswordHidden ?? this.isCurrentPasswordHidden,
      isNewPasswordHidden: isNewPasswordHidden ?? this.isNewPasswordHidden,
      isConfirmNewPasswordHidden: isConfirmNewPasswordHidden ?? this.isConfirmNewPasswordHidden,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
