import 'package:heal_v/common/bloc/side_effect/side_effect.dart';

sealed class SignUpPageSideEffect implements SideEffect {
  const SignUpPageSideEffect();

  factory SignUpPageSideEffect.validated() => Validated();
}

final class Validated extends SignUpPageSideEffect {
  Validated();
}
