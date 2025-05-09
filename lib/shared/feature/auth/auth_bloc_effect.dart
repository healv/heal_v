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

  factory AuthBlocEffect.notLoggedIn() => NotLoggedIn._(ResourceStatusEnum.success);
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

final class NotLoggedIn extends AuthBlocEffect {
  NotLoggedIn._(super.status);
}
