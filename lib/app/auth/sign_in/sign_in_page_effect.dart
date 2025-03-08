import 'package:heal_v/common/bloc/side_effect/side_effect.dart';

sealed class SignInPageSideEffect implements SideEffect {
  const SignInPageSideEffect();

  factory SignInPageSideEffect.validated() => Validated();
}

final class Validated extends SignInPageSideEffect {
  Validated();
}
