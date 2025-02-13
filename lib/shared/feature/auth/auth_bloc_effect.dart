import '../../../common/bloc/side_effect/side_effect.dart';
import '../../../common/utils/resource.dart';

sealed class AuthBlocEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  AuthBlocEffect(this.status, {this.errorMsg});

  factory AuthBlocEffect.loggedOut(ResourceStatusEnum status) => LoggedOut._(status);
}

final class LoggedOut extends AuthBlocEffect {
  LoggedOut._(super.status);
}
