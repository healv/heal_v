import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';

import '../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../common/bloc/side_effect/side_effect_bloc.dart';
import '../../../../../common/dart/optional.dart';
import '../../../../../common/tools/localization_tools.dart';
import '../../../../../common/utils/resource.dart';

part 'change_password_page_effect.dart';
part 'change_password_page_event.dart';
part 'change_password_page_state.dart';

class ChangePasswordPageBloc extends SideEffectBloc<ChangePasswordPageEvent, ChangePasswordPageState, ChangePasswordPageSideEffect> {
  ChangePasswordPageBloc() : super(ChangePasswordPageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<CurrentPasswordChanged>(_handleCurrentPasswordChangedEvent);
    on<NewPasswordChanged>(_handleNewPasswordChangedEvent);
    on<ConfirmNewPasswordChanged>(_handleConfirmNewPasswordChangedEvent);
    on<ValidatePasswordsMatch>(_handleValidatePasswordsMatchEvent);
    on<Validate>(_handleValidateEvent);
    on<CurrentPasswordVisibilityChanged>(_handleCurrentPasswordVisibilityChangedEvent);
    on<NewPasswordVisibilityChanged>(_handleNewPasswordVisibilityChangedEvent);
    on<ConfirmNewPasswordVisibilityChanged>(_handleConfirmNewPasswordVisibilityChangedEvent);
    on<CurrentPasswordErrorMsgChanged>(_handleCurrentPasswordErrorMsgChangedEvent);
    on<LoadingStateChanged>(_handleLoadingStateChangedChangedEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<ChangePasswordPageState> emitter) async {}

  Future<void> _handleCurrentPasswordChangedEvent(CurrentPasswordChanged event, Emitter<ChangePasswordPageState> emitter) async {
    emitter(state.copyWith(currentPassword: Optional.value(event.password)));
    if (_isValidPassword(event.password)) {
      emitter(state.copyWith(currentPasswordErrorMsg: const Optional.value(null)));
    } else {
      emitter(state.copyWith(currentPasswordErrorMsg: Optional.value(tr('invalid_password'))));
    }
  }

  Future<void> _handleNewPasswordChangedEvent(NewPasswordChanged event, Emitter<ChangePasswordPageState> emitter) async {
    emitter(state.copyWith(newPassword: Optional.value(event.password)));
    if (_isValidPassword(event.password)) {
      add(ChangePasswordPageEvent.validatePasswordsMatch(state.newPassword, state.confirmNewPassword));
    } else {
      emitter(
        state.copyWith(
          newPasswordErrorMsg: Optional.value(tr('invalid_password')),
        ),
      );
    }
  }

  Future<void> _handleConfirmNewPasswordChangedEvent(ConfirmNewPasswordChanged event, Emitter<ChangePasswordPageState> emitter) async {
    emitter(state.copyWith(confirmNewPassword: Optional.value(event.password)));
    if (_isValidPassword(event.password)) {
      add(ChangePasswordPageEvent.validatePasswordsMatch(state.newPassword, state.confirmNewPassword));
    } else {
      emitter(
        state.copyWith(
          confirmNewPasswordErrorMsg: Optional.value(tr('invalid_password')),
        ),
      );
    }
  }

  Future<void> _handleValidatePasswordsMatchEvent(ValidatePasswordsMatch event, Emitter<ChangePasswordPageState> emitter) async {
    if (_isPasswordsMatch(event.newPassword, event.confirmNewPassword)) {
      emitter(
        state.copyWith(
          newPasswordErrorMsg: const Optional.value(null),
          confirmNewPasswordErrorMsg: const Optional.value(null),
        ),
      );
    } else {
      emitter(
        state.copyWith(
          newPasswordErrorMsg: const Optional.value(null),
          confirmNewPasswordErrorMsg: Optional.value(tr('yourPasswordsMustMatch')),
        ),
      );
    }
  }

  Future<void> _handleValidateEvent(Validate event, Emitter<ChangePasswordPageState> emitter) async {
    if (_isValidPassword(event.currentPassword)) {
      emitter(state.copyWith(currentPasswordErrorMsg: const Optional.value(null)));
    } else {
      emitter(state.copyWith(currentPasswordErrorMsg: Optional.value(tr('invalid_password'))));
    }

    if (_isValidPassword(event.newPassword)) {
      add(ChangePasswordPageEvent.validatePasswordsMatch(event.newPassword, event.confirmNewPassword));
    } else {
      emitter(state.copyWith(newPasswordErrorMsg: Optional.value(tr('invalid_password'))));
    }

    if (_isValidPassword(event.confirmNewPassword)) {
      add(ChangePasswordPageEvent.validatePasswordsMatch(event.newPassword, event.confirmNewPassword));
    } else {
      emitter(state.copyWith(confirmNewPasswordErrorMsg: Optional.value(tr('invalid_password'))));
    }

    if (state.currentPasswordErrorMsg == null && state.newPasswordErrorMsg == null && state.confirmNewPasswordErrorMsg == null) {
      addSideEffect(
        ChangePasswordPageSideEffect.validated(
          ResourceStatusEnum.success,
          currentPassword: state.currentPassword,
          newPassword: state.newPassword,
        ),
      );
    } else {
      addSideEffect(
        ChangePasswordPageSideEffect.validated(ResourceStatusEnum.error),
      );
    }
  }

  Future<void> _handleCurrentPasswordVisibilityChangedEvent(CurrentPasswordVisibilityChanged event, Emitter<ChangePasswordPageState> emitter) async {
    emitter(state.copyWith(isCurrentPasswordHidden: !state.isCurrentPasswordHidden));
  }

  Future<void> _handleNewPasswordVisibilityChangedEvent(NewPasswordVisibilityChanged event, Emitter<ChangePasswordPageState> emitter) async {
    emitter(state.copyWith(isNewPasswordHidden: !state.isNewPasswordHidden));
  }

  Future<void> _handleConfirmNewPasswordVisibilityChangedEvent(ConfirmNewPasswordVisibilityChanged event, Emitter<ChangePasswordPageState> emitter) async {
    emitter(state.copyWith(isConfirmNewPasswordHidden: !state.isConfirmNewPasswordHidden));
  }

  Future<void> _handleCurrentPasswordErrorMsgChangedEvent(CurrentPasswordErrorMsgChanged event, Emitter<ChangePasswordPageState> emitter) async {
    emitter(state.copyWith(currentPasswordErrorMsg: Optional.value(event.errorMessage)));
  }

  Future<void> _handleLoadingStateChangedChangedEvent(LoadingStateChanged event, Emitter<ChangePasswordPageState> emitter) async {
    emitter(state.copyWith(isLoading: event.isLoading));
  }

  bool _isValidPassword(String? password) {
    final newPassword = password?.trim();
    return (newPassword?.length ?? 0) > 5;
  }

  bool _isPasswordsMatch(String? newPassword, String? confirmNewPassword) {
    return newPassword == confirmNewPassword;
  }
}
