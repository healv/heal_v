import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc_effect.dart';

import '../../../common/bloc/base_event.dart';
import '../../../common/bloc/base_state.dart';
import '../../../common/dart/optional.dart';

part 'auth_bloc_event.dart';

part 'auth_bloc_state.dart';

final class AuthBloc extends SideEffectBloc<AuthBlocEvent, AuthBlocState, AuthBlocEffect> {
  AuthBloc() : super(AuthBlocState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<Logout>(_handleLogoutEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<AuthBlocState> emitter) async {
    await Future.delayed(const Duration(seconds: 2));
    emitter(state.copyWith(accessToken: const Optional.value('blaa')));
  }

  Future<void> _handleLogoutEvent(Logout event, Emitter<AuthBlocState> emitter) async {
    addSideEffect(AuthBlocEffect.loggedOut(ResourceStatusEnum.success));
  }
}
