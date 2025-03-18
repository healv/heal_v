import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/tools/store.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/common/utils/store_key.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/packet/login_packet.dart';
import 'package:heal_v/feature/heal_v/api/auth/repo/auth_repo.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc_effect.dart';

import '../../../common/bloc/base_event.dart';
import '../../../common/bloc/base_state.dart';
import '../../../common/dart/optional.dart';

part 'auth_bloc_event.dart';

part 'auth_bloc_state.dart';

final class AuthBloc extends SideEffectBloc<AuthBlocEvent, AuthBlocState, AuthBlocEffect> {
  final AuthRepo repo;

  AuthBloc(this.repo) : super(AuthBlocState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<SignUp>(_handleSignUpEvent);
    on<SignIn>(_handleSignInEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<AuthBlocState> emitter) async {
    final savedAccessToken = await Store.get(key: StoreKey.accessToken, defaultValue: emptyString);
    if (savedAccessToken.isNotEmpty) {
      await for (final response in repo.getMe(savedAccessToken)) {
        switch (response.status) {
          case ResourceStatusEnum.success:
            emitter(state.copyWith(accessToken: Optional.value(savedAccessToken)));
            addSideEffect(AuthBlocEffect.loggedIn(ResourceStatusEnum.success));
            break;
          case ResourceStatusEnum.error:
            addSideEffect(AuthBlocEffect.loggedIn(ResourceStatusEnum.error, errorMsg: response.error));
            debugPrint(response.error.toString());
            break;
          case ResourceStatusEnum.loading:
            break;
        }
      }
    } else {
      await Future.delayed(const Duration(seconds: 2));
      addSideEffect(AuthBlocEffect.notLoggedIn());
    }
  }

  Future<void> _handleSignUpEvent(SignUp event, Emitter<AuthBlocState> emitter) async {
    await for (final response in repo.signUp(LoginPacket(email: event.email, password: event.password))) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(accessToken: Optional.value(response.data?.accessToken), user: Optional.value(response.data?.user), loading: const Optional.value(true)));
          Store.set(key: StoreKey.accessToken, value: response.data?.accessToken);
          debugPrint(response.data.toString());
          addSideEffect(AuthBlocEffect.signedUp(ResourceStatusEnum.success));
          break;
        case ResourceStatusEnum.error:
          debugPrint(response.error.toString());
          emitter(state.copyWith(loading: const Optional.value(false)));
          addSideEffect(AuthBlocEffect.signedUp(ResourceStatusEnum.error, errorMsg: response.error));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(loading: const Optional.value(true)));
          break;
      }
    }
  }

  Future<void> _handleSignInEvent(SignIn event, Emitter<AuthBlocState> emitter) async {
    await for (final response in repo.login(LoginPacket(email: event.email, password: event.password))) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(accessToken: Optional.value(response.data?.accessToken), user: Optional.value(response.data?.user), loading: const Optional.value(false)));
          Store.set(key: StoreKey.accessToken, value: response.data?.accessToken);
          debugPrint(response.data.toString());
          addSideEffect(AuthBlocEffect.loggedIn(ResourceStatusEnum.success));
          break;
        case ResourceStatusEnum.error:
          debugPrint(response.error.toString());
          addSideEffect(AuthBlocEffect.loggedIn(ResourceStatusEnum.error, errorMsg: response.error));
          emitter(state.copyWith(loading: const Optional.value(false)));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(loading: const Optional.value(true)));
          break;
      }
    }
  }
}
