import 'package:heal_v/common/bloc/side_effect/side_effect.dart';

import '../../../../../common/utils/resource.dart';

sealed class SignInPageSideEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  const SignInPageSideEffect(this.status, {this.errorMsg});

  factory SignInPageSideEffect.firstNameValidated(ResourceStatusEnum status, {String? errorMsg}) => PasswordValidated(status, errorMsg: errorMsg);

  factory SignInPageSideEffect.emailValidated(ResourceStatusEnum status, {String? errorMsg}) => EmailValidated(status, errorMsg: errorMsg);

  factory SignInPageSideEffect.validated(ResourceStatusEnum status, {String? errorMsg}) => Validated(status, errorMsg: errorMsg);
}

final class PasswordValidated extends SignInPageSideEffect {
  PasswordValidated(super.status, {super.errorMsg});
}

final class EmailValidated extends SignInPageSideEffect {
  EmailValidated(super.status, {super.errorMsg});
}

final class Validated extends SignInPageSideEffect {
  Validated(super.status, {super.errorMsg});
}
