import 'package:heal_v/common/bloc/side_effect/side_effect.dart';

import '../../../../../common/utils/resource.dart';

sealed class EditProfilePageSideEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  const EditProfilePageSideEffect(this.status, {this.errorMsg});

  factory EditProfilePageSideEffect.firstNameValidated(ResourceStatusEnum status, {String? errorMsg}) => FirstNameValidated(status, errorMsg: errorMsg);

  factory EditProfilePageSideEffect.validated(
    ResourceStatusEnum status, {
    String? name,
    String? lastName,
    String? birthDate,
    String? errorMsg,
  }) =>
      Validated(status, name: name, lastName: lastName, birthDate: birthDate, errorMsg: errorMsg);
}

final class FirstNameValidated extends EditProfilePageSideEffect {
  FirstNameValidated(super.status, {super.errorMsg});
}

final class Validated extends EditProfilePageSideEffect {
  final String? name;
  final String? lastName;
  final String? birthDate;

  Validated(super.status, {this.name, this.lastName, this.birthDate, super.errorMsg});
}
