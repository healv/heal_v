import 'package:heal_v/common/bloc/side_effect/side_effect.dart';

import '../../../../../common/utils/resource.dart';

sealed class EditProfilePageSideEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  const EditProfilePageSideEffect(this.status, {this.errorMsg});

  factory EditProfilePageSideEffect.firstNameValidated(ResourceStatusEnum status, {String? errorMsg}) => FirstNameValidated(status, errorMsg: errorMsg);

  factory EditProfilePageSideEffect.emailValidated(ResourceStatusEnum status, {String? errorMsg}) => EmailValidated(status, errorMsg: errorMsg);

  factory EditProfilePageSideEffect.validated(ResourceStatusEnum status, {String? errorMsg}) => Validated(status, errorMsg: errorMsg);
}

final class FirstNameValidated extends EditProfilePageSideEffect {
  FirstNameValidated(super.status, {super.errorMsg});
}

final class EmailValidated extends EditProfilePageSideEffect {
  EmailValidated(super.status, {super.errorMsg});
}

final class Validated extends EditProfilePageSideEffect {
  Validated(super.status, {super.errorMsg});
}
