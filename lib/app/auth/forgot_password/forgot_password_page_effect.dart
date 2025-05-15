part of 'forgot_password_page_bloc.dart';

sealed class ForgotPasswordPageEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  const ForgotPasswordPageEffect(this.status, {this.errorMsg});

  factory ForgotPasswordPageEffect.validated(
    ResourceStatusEnum status, {
    String? email,
    String? errorMsg,
  }) =>
      Validated(
        status,
        email: email,
        errorMsg: errorMsg,
      );
}

final class Validated extends ForgotPasswordPageEffect {
  final String? email;

  Validated(super.status, {this.email, super.errorMsg});
}
