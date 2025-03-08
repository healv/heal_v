import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/auth/sign_in/sign_in_page_effect.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/tools/localization_tools.dart';

import '../../../common/bloc/base_state.dart';

part 'sign_in_page_event.dart';

part 'sign_in_page_state.dart';

class SignInPageBloc extends SideEffectBloc<SignInPageEvent, SignInPageState, SignInPageSideEffect> {
  SignInPageBloc() : super(SignInPageState.initial()) {
    on<EmailChanged>(_handleEmailChangedEvent);
    on<PasswordChanged>(_handlePasswordChangedEvent);
    on<Validate>(_handleValidateEvent);
  }

  Future<void> _handleEmailChangedEvent(EmailChanged event, Emitter<SignInPageState> emitter) async {
    emitter(state.copyWith(email: Optional.value(event.email)));
  }

  Future<void> _handlePasswordChangedEvent(PasswordChanged event, Emitter<SignInPageState> emitter) async {
    emitter(state.copyWith(password: Optional.value(event.password)));
  }

  Future<void> _handleValidateEvent(Validate event, Emitter<SignInPageState> emitter) async {
    if (!_isValidEmail()) {
      emitter(state.copyWith(emailErrorMsg: Optional.value(tr('invalid_email'))));
      return;
    }

    if (!_isValidPassword()) {
      emitter(state.copyWith(
        emailErrorMsg: const Optional.value(null),
        passwordErrorMsg: Optional.value(tr('invalid_password')),
      ));
      return;
    }
    emitter(state.copyWith(emailErrorMsg: const Optional.value(null), passwordErrorMsg: const Optional.value(null)));
    addSideEffect(SignInPageSideEffect.validated());
  }

  bool _isValidEmail() {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(state.email.toString());
  }

  bool _isValidPassword() {
    final password = state.password?.trim();
    return password != null && password.length > 5;
  }
}
