import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/tools/store.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/common/utils/store_key.dart';
import 'package:heal_v/feature/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/auth/packet/login_packet.dart';
import 'package:heal_v/feature/auth/repo/auth_repo.dart';
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
      final response = await repo.getMe(savedAccessToken);
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(accessToken: Optional.value(savedAccessToken)));
          addSideEffect(AuthBlocEffect.loggedIn(ResourceStatusEnum.success));
          break;
        case ResourceStatusEnum.error:
          addSideEffect(AuthBlocEffect.loggedIn(ResourceStatusEnum.error));
          debugPrint(response.error.toString());
          break;
        case ResourceStatusEnum.loading:
          break;
      }
    } else {
      await Future.delayed(const Duration(seconds: 2));
      addSideEffect(AuthBlocEffect.notLoggedIn());
    }
  }

  Future<void> _handleSignUpEvent(SignUp event, Emitter<AuthBlocState> emitter) async {
    final response = await repo.signUp(LoginPacket(email: 'harutyunyanedik1992@gmail.com', password: 'Test1234'));
    switch (response.status) {
      case ResourceStatusEnum.success:
        emitter(state.copyWith(accessToken: Optional.value(response.data?.accessToken), user: Optional.value(response.data?.user)));
        Store.set(key: StoreKey.accessToken, value: response.data?.accessToken);
        debugPrint(response.data.toString());
        break;
      case ResourceStatusEnum.error:
        debugPrint(response.error.toString());
        break;
      case ResourceStatusEnum.loading:
        break;
    }
    addSideEffect(AuthBlocEffect.signedUp(ResourceStatusEnum.success));
  }

  Future<void> _handleSignInEvent(SignIn event, Emitter<AuthBlocState> emitter) async {
    final response = await repo.login(LoginPacket(email: 'harutyunyanedik1992@gmail.com', password: 'Test1234'));
    switch (response.status) {
      case ResourceStatusEnum.success:
        emitter(state.copyWith(accessToken: Optional.value(response.data?.accessToken), user: Optional.value(response.data?.user)));
        Store.set(key: StoreKey.accessToken, value: response.data?.accessToken);
        debugPrint(response.data.toString());
        break;
      case ResourceStatusEnum.error:
        debugPrint(response.error.toString());
        break;
      case ResourceStatusEnum.loading:
        break;
    }
    addSideEffect(AuthBlocEffect.loggedIn(ResourceStatusEnum.success));
  }
}
