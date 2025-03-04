import '../../../common/bloc/side_effect/side_effect.dart';
import '../../../common/utils/resource.dart';

sealed class AuthBlocEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  AuthBlocEffect(this.status, {this.errorMsg});

  factory AuthBlocEffect.loggedOut(ResourceStatusEnum status) => LoggedOut._(status);

  factory AuthBlocEffect.loggedIn(ResourceStatusEnum status) => LoggedIn._(status);

  factory AuthBlocEffect.signedUp(ResourceStatusEnum status) => SignedUp._(status);

  factory AuthBlocEffect.notLoggedIn() => NotLoggedIn._(ResourceStatusEnum.success);
}

final class LoggedOut extends AuthBlocEffect {
  LoggedOut._(super.status);
}

final class LoggedIn extends AuthBlocEffect {
  LoggedIn._(super.status);
}

final class SignedUp extends AuthBlocEffect {
  SignedUp._(super.status);
}

final class NotLoggedIn extends AuthBlocEffect {
  NotLoggedIn._(super.status);
}
