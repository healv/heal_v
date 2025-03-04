import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/auth/sign_in/sign_in_page_effect.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/resource.dart';

import '../../../common/bloc/base_state.dart';

part 'sign_in_page_event.dart';

part 'sign_in_page_state.dart';

class SignInPageBloc extends SideEffectBloc<SignInPageEvent, SignInPageState, SignInPageSideEffect> {
  SignInPageBloc() : super(SignInPageState.initial()) {
    on<EmailChanged>(_handleEmailChangedEvent);
    on<PasswordChanged>(_handlePasswordChangedEvent);
    on<ValidateEmail>(_handleValidateEmailEvent);
    on<ValidatePassword>(_handleValidatePasswordEvent);
    on<EmailFocusChanged>(_handleEmailFocusChangedEvent);
    on<PasswordFocusChanged>(_handlePasswordFocusChangedEvent);
  }

  Future<void> _handleEmailChangedEvent(EmailChanged event, Emitter<SignInPageState> emitter) async {
    emitter(state.copyWith(email: Optional.value(event.email)));
  }

  Future<void> _handlePasswordChangedEvent(PasswordChanged event, Emitter<SignInPageState> emitter) async {
    emitter(state.copyWith(password: Optional.value(event.password)));
  }

  Future<void> _handleValidateEmailEvent(ValidateEmail event, Emitter<SignInPageState> emitter) async {
    SignInPageSideEffect.emailValidated(ResourceStatusEnum.loading);
    if (_isValidEmail()) {
      emitter(state.copyWith(emailErrorMsg: const Optional.value(null)));
      addSideEffect(SignInPageSideEffect.emailValidated(ResourceStatusEnum.success));
    } else {
      emitter(state.copyWith(emailErrorMsg: Optional.value(tr('invalid_field'))));
      addSideEffect(SignInPageSideEffect.emailValidated(ResourceStatusEnum.error));
    }
  }

  Future<void> _handleValidatePasswordEvent(ValidatePassword event, Emitter<SignInPageState> emitter) async {
    SignInPageSideEffect.emailValidated(ResourceStatusEnum.loading);
    if (_isValidPassword()) {
      emitter(state.copyWith(passwordErrorMsg: const Optional.value(null)));
      addSideEffect(SignInPageSideEffect.emailValidated(ResourceStatusEnum.success));
    } else {
      emitter(state.copyWith(passwordErrorMsg: Optional.value(tr('invalid_field'))));
      addSideEffect(SignInPageSideEffect.emailValidated(ResourceStatusEnum.error));
    }
  }

  Future<void> _handleEmailFocusChangedEvent(EmailFocusChanged event, Emitter<SignInPageState> emitter) async {
    emitter(state.copyWith(isEmailFocused: event.isFocused));
  }

  Future<void> _handlePasswordFocusChangedEvent(PasswordFocusChanged event, Emitter<SignInPageState> emitter) async {
    emitter(state.copyWith(isPasswordFocused: event.isFocused));
  }

  bool _isValidEmail() {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(state.email.toString());
  }

  bool _isValidPassword() {
    final password = state.password?.trim();
    return password != null && password.isNotEmpty;
  }
}
