import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/auth/sign_up/sign_up_page_effect.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/tools/localization_tools.dart';

part 'sign_up_page_event.dart';

part 'sign_up_page_state.dart';

class SignUpPageBloc extends SideEffectBloc<SignUpPageEvent, SignUpPageState, SignUpPageSideEffect> {
  SignUpPageBloc() : super(SignUpPageState.initial()) {
    on<FirstNameChanged>(_handleFirstNameChangedEvent);
    on<EmailChanged>(_handleEmailChangedEvent);
    on<PasswordChanged>(_handlePasswordChangedEvent);
    on<RepeatPasswordChanged>(_handleRepeatPasswordChangedEvent);
    on<Validate>(_handleValidateEvent);
  }

  Future<void> _handleEmailChangedEvent(EmailChanged event, Emitter<SignUpPageState> emitter) async {
    emitter(state.copyWith(email: Optional.value(event.email)));
  }

  Future<void> _handleFirstNameChangedEvent(FirstNameChanged event, Emitter<SignUpPageState> emitter) async {
    emitter(state.copyWith(firstName: Optional.value(event.firstName)));
  }

  Future<void> _handlePasswordChangedEvent(PasswordChanged event, Emitter<SignUpPageState> emitter) async {
    emitter(state.copyWith(password: Optional.value(event.password)));
  }

  Future<void> _handleRepeatPasswordChangedEvent(RepeatPasswordChanged event, Emitter<SignUpPageState> emitter) async {
    emitter(state.copyWith(repeatPassword: Optional.value(event.password)));
  }

  Future<void> _handleValidateEvent(Validate event, Emitter<SignUpPageState> emitter) async {
    if (!_isValidFirstName()) {
      emitter(state.copyWith(firstNameErrorMsg: Optional.value(tr('invalid_first_name'))));
      return;
    }

    if (!_isValidEmail()) {
      emitter(
        state.copyWith(
          firstNameErrorMsg: const Optional.value(null),
          emailErrorMsg: Optional.value(tr('invalid_email')),
        ),
      );
      return;
    }

    if (!_isValidPassword()) {
      emitter(
        state.copyWith(
          firstNameErrorMsg: const Optional.value(null),
          emailErrorMsg: const Optional.value(null),
          passwordErrorMsg: Optional.value(tr('invalid_password')),
        ),
      );
      return;
    }

    if (!_isPasswordMatchToConfirmPassword()) {
      emitter(
        state.copyWith(
          firstNameErrorMsg: const Optional.value(null),
          emailErrorMsg: const Optional.value(null),
          passwordErrorMsg: Optional.value(tr('password_not_match')),
          repeatPasswordErrorMsg: Optional.value(tr('password_not_match')),
        ),
      );
      return;
    }

    emitter(
      state.copyWith(
        firstNameErrorMsg: const Optional.value(null),
        emailErrorMsg: const Optional.value(null),
        passwordErrorMsg: const Optional.value(null),
        repeatPasswordErrorMsg: const Optional.value(null),
      ),
    );
    addSideEffect(SignUpPageSideEffect.validated());
  }

  bool _isValidFirstName() {
    final firstName = state.firstName?.trim();
    return firstName != null && firstName.isNotEmpty;
  }

  bool _isValidEmail() {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(state.email.toString());
  }

  bool _isValidPassword() {
    final password = state.password?.trim();
    return password != null && password.length > 5;
  }

  bool _isPasswordMatchToConfirmPassword() {
    final password = state.password;
    final repeatPassword = state.repeatPassword;
    return password != null && repeatPassword != null && password == repeatPassword;
  }
}
