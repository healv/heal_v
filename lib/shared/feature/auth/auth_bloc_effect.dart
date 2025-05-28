import '../../../common/bloc/side_effect/side_effect.dart';
import '../../../common/utils/resource.dart';

sealed class AuthBlocEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  AuthBlocEffect(this.status, {this.errorMsg});

  factory AuthBlocEffect.loggedOut(ResourceStatusEnum status, {String? errorMsg}) => LoggedOut._(status, errorMsg: errorMsg);

  factory AuthBlocEffect.loggedIn(ResourceStatusEnum status, {String? errorMsg}) => LoggedIn._(status, errorMsg: errorMsg);

  factory AuthBlocEffect.signedUp(ResourceStatusEnum status, {String? errorMsg}) => SignedUp._(status, errorMsg: errorMsg);

  factory AuthBlocEffect.userUpdated(ResourceStatusEnum status, {String? errorMsg}) => UserUpdated._(status, errorMsg: errorMsg);

  factory AuthBlocEffect.imageUploaded(ResourceStatusEnum status, {String? errorMsg}) => ImageUploaded._(status, errorMsg: errorMsg);

  factory AuthBlocEffect.imageDeleted(ResourceStatusEnum status, {String? errorMsg}) => ImageDeleted._(status, errorMsg: errorMsg);

  factory AuthBlocEffect.notLoggedIn() => NotLoggedIn._(ResourceStatusEnum.success);

  factory AuthBlocEffect.passwordChanged(ResourceStatusEnum status, {String? errorMsg}) => PasswordChanged._(status, errorMsg: errorMsg);

  factory AuthBlocEffect.passwordRecovered(ResourceStatusEnum status, {String? errorMsg}) => PasswordRecovered._(status, errorMsg: errorMsg);
}

final class LoggedOut extends AuthBlocEffect {
  LoggedOut._(super.status, {super.errorMsg});
}

final class LoggedIn extends AuthBlocEffect {
  LoggedIn._(super.status, {super.errorMsg});
}

final class SignedUp extends AuthBlocEffect {
  SignedUp._(super.status, {super.errorMsg});
}

final class UserUpdated extends AuthBlocEffect {
  UserUpdated._(super.status, {super.errorMsg});
}

final class ImageUploaded extends AuthBlocEffect {
  ImageUploaded._(super.status, {super.errorMsg});
}

final class ImageDeleted extends AuthBlocEffect {
  ImageDeleted._(super.status, {super.errorMsg});
}

final class NotLoggedIn extends AuthBlocEffect {
  NotLoggedIn._(super.status);
}

final class PasswordChanged extends AuthBlocEffect {
  PasswordChanged._(super.status, {super.errorMsg});
}

final class PasswordRecovered extends AuthBlocEffect {
  PasswordRecovered._(super.status, {super.errorMsg});
}
