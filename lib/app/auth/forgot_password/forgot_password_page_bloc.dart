import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';

import '../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../common/bloc/side_effect/side_effect_bloc.dart';
import '../../../../../common/dart/optional.dart';
import '../../../../../common/utils/resource.dart';
import '../../../common/tools/localization_tools.dart';

part 'forgot_password_page_effect.dart';
part 'forgot_password_page_event.dart';
part 'forgot_password_page_state.dart';

class ForgotPasswordPageBloc extends SideEffectBloc<ForgotPasswordPageEvent, ForgotPasswordPageState, ForgotPasswordPageEffect> {
  ForgotPasswordPageBloc() : super(ForgotPasswordPageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<EmailChanged>(_handleEmailChangedEvent);
    on<EmailErrorMsgChanged>(_handleEmailErrorMsgChangedEvent);
    on<Validate>(_handleValidateEvent);
    on<LoadingStateChanged>(_handleLoadingStateChangedChangedEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<ForgotPasswordPageState> emitter) async {}

  Future<void> _handleEmailChangedEvent(EmailChanged event, Emitter<ForgotPasswordPageState> emitter) async {
    emitter(state.copyWith(email: Optional.value(event.email)));
    if (_isValidEmail()) {
      emitter(state.copyWith(emailErrorMsg: const Optional.value(null)));
    } else {
      emitter(state.copyWith(emailErrorMsg: Optional.value(tr('invalid_email'))));
    }
  }

  Future<void> _handleEmailErrorMsgChangedEvent(EmailErrorMsgChanged event, Emitter<ForgotPasswordPageState> emitter) async {
    emitter(state.copyWith(emailErrorMsg: Optional.value(event.errorMessage)));
  }

  Future<void> _handleValidateEvent(Validate event, Emitter<ForgotPasswordPageState> emitter) async {
    emitter(state.copyWith(email: Optional.value(event.email)));
    if (_isValidEmail()) {
      emitter(state.copyWith(emailErrorMsg: const Optional.value(null)));
    } else {
      emitter(state.copyWith(emailErrorMsg: Optional.value(tr('invalid_email'))));
    }

    if (state.emailErrorMsg == null || state.emailErrorMsg?.isEmpty == true) {
      addSideEffect(ForgotPasswordPageEffect.validated(ResourceStatusEnum.success, email: event.email));
    } else {
      addSideEffect(ForgotPasswordPageEffect.validated(ResourceStatusEnum.error, email: event.email));
    }
  }

  Future<void> _handleLoadingStateChangedChangedEvent(LoadingStateChanged event, Emitter<ForgotPasswordPageState> emitter) async {
    emitter(state.copyWith(isLoading: event.isLoading));
  }

  bool _isValidEmail() {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(state.email.toString());
  }
}
