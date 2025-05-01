import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/tools/store.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/common/utils/store_key.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/feature/heal_v/api/auth/repo/auth_repo.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc_effect.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../application.dart';
import '../../../common/bloc/base_event.dart';
import '../../../common/bloc/base_state.dart';
import '../../../common/dart/optional.dart';
import '../../../navigation/auth/auth_graph.dart';

part 'auth_bloc_event.dart';

part 'auth_bloc_state.dart';

final class AuthBloc extends SideEffectBloc<AuthBlocEvent, AuthBlocState, AuthBlocEffect> {
  final AuthRepo repo;
  late final StreamSubscription<User?> _authSubscription;

  AuthBloc(this.repo) : super(AuthBlocState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<SignUp>(_handleSignUpEvent);
    on<SignIn>(_handleSignInEvent);
    on<SignInWithGoogle>(_handleSignInFirebaseEvent);
    on<GetMe>(_handleMeEvent);
  }

  Future<void> _subscribeToFirebaseUser() async {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) async {
      log('$healVTag authStateChanges: user: $user');
      if (state.user != null && user == null) {
        await _logout();
        addSideEffect(AuthBlocEffect.loggedOut(ResourceStatusEnum.success));
      }
    });
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<AuthBlocState> emitter) async {
    final permissionGranted = await Permission.notification.isGranted;
    final permissionAlwaysDenied = await Permission.notification.isPermanentlyDenied;
    if (!permissionGranted && !permissionAlwaysDenied) {
      final status = await PermissionRoute().push<PermissionStatus>(shellNavigatorGlobalKey.currentContext!) ?? PermissionStatus.denied;
      Store.set(key: StoreKey.notificationEnable, value: status.isGranted);
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      add(AuthBlocEvent.me());
    } else {
      addSideEffect(AuthBlocEffect.notLoggedIn());
    }
    _subscribeToFirebaseUser();
  }

  Future<void> _handleSignInEvent(SignIn event, Emitter<AuthBlocState> emitter) async {
    try {
      emitter(state.copyWith(loading: const Optional.value(true)));
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: event.email, password: event.password);
      log('$healVTag isNewUser: ${userCredential.additionalUserInfo?.isNewUser}');
      if (userCredential.user != null) {
        add(AuthBlocEvent.me());
      } else {
        log('$healVTag authorizationCode: ${userCredential.additionalUserInfo?.authorizationCode}');
        emitter(state.copyWith(loading: const Optional.value(false)));
        addSideEffect(AuthBlocEffect.notLoggedIn());
      }
    } on FirebaseAuthException catch (error) {
      log('$healVTag authorizationError: $error');
      emitter(state.copyWith(loading: const Optional.value(false)));
      addSideEffect(AuthBlocEffect.loggedIn(ResourceStatusEnum.error, errorMsg: error.message));
    } catch (e) {
      log('$healVTag authorizationError: $e');
      emitter(state.copyWith(loading: const Optional.value(false)));
    }
  }

  Future<void> _handleSignInFirebaseEvent(SignInWithGoogle event, Emitter<AuthBlocState> emitter) async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        addSideEffect(AuthBlocEffect.notLoggedIn());
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      emitter(state.copyWith(loading: const Optional.value(true)));
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      log('$healVTag isNewUser: ${userCredential.additionalUserInfo?.isNewUser}');
      if (userCredential.user != null) {
        add(AuthBlocEvent.me());
      } else {
        emitter(state.copyWith(loading: const Optional.value(false)));
        addSideEffect(AuthBlocEffect.notLoggedIn());
      }
    } on FirebaseAuthException catch (error) {
      emitter(state.copyWith(loading: const Optional.value(false)));
      log('$healVTag authorizationError: $error');
      emitter(state.copyWith(loading: const Optional.value(false)));
      addSideEffect(AuthBlocEffect.loggedIn(ResourceStatusEnum.error, errorMsg: error.message));
    } catch (error) {
      emitter(state.copyWith(loading: const Optional.value(false)));
      debugPrint("Error Google: $error");
    }
  }

  Future<void> _handleSignUpEvent(SignUp event, Emitter<AuthBlocState> emitter) async {
    try {
      emitter(state.copyWith(loading: const Optional.value(true)));
      final userCredentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: event.email, password: event.password);
      if (userCredentials.user != null) {
        log('$healVTag signUp: user: ${userCredentials.user}');
        await userCredentials.user?.updateDisplayName('${event.name} ${event.lastName}');
        await userCredentials.user?.reload();
        add(AuthBlocEvent.me());
      } else {
        emitter(state.copyWith(loading: const Optional.value(false)));
        addSideEffect(AuthBlocEffect.signedUp(ResourceStatusEnum.error));
      }
    } on FirebaseAuthException catch (error) {
      emitter(state.copyWith(loading: const Optional.value(false)));
      log('$healVTag authorizationError: $error');
      emitter(state.copyWith(loading: const Optional.value(false)));
      addSideEffect(AuthBlocEffect.signedUp(ResourceStatusEnum.error, errorMsg: error.message));
    } catch (error) {
      emitter(state.copyWith(loading: const Optional.value(false)));
      debugPrint("Error Google: $error");
    }

    // await for (final response in repo.signUp(SignUpPacket(email: event.email, password: event.password, name: event.name, lastName: event.lastName))) {
    //   switch (response.status) {
    //     case ResourceStatusEnum.success:
    //       emitter(state.copyWith(
    //         // accessToken: Optional.value(response.data?.accessToken),
    //         user: Optional.value(response.data?.user),
    //         loading: const Optional.value(true),
    //       ));
    //       Store.set(key: StoreKey.accessToken, value: response.data?.accessToken);
    //       Store.set(key: StoreKey.refreshToken, value: response.data?.refreshToken);
    //       debugPrint(response.data.toString());
    //       addSideEffect(AuthBlocEffect.signedUp(ResourceStatusEnum.success));
    //       break;
    //     case ResourceStatusEnum.error:
    //       debugPrint(response.error.toString());
    //       emitter(state.copyWith(loading: const Optional.value(false)));
    //       addSideEffect(AuthBlocEffect.signedUp(ResourceStatusEnum.error, errorMsg: response.error));
    //       break;
    //     case ResourceStatusEnum.loading:
    //       emitter(state.copyWith(loading: const Optional.value(true)));
    //       break;
    //   }
    // }
  }

  Future<void> _handleMeEvent(GetMe event, Emitter<AuthBlocState> emitter) async {
    await for (final response in repo.getMe()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(user: Optional.value(response.data?.user), loading: const Optional.value(false)));
          addSideEffect(AuthBlocEffect.loggedIn(ResourceStatusEnum.success));
          break;
        case ResourceStatusEnum.error:
          await _logout();
          emitter(state.copyWith(loading: const Optional.value(false)));
          addSideEffect(AuthBlocEffect.loggedIn(ResourceStatusEnum.error, errorMsg: response.error));
          debugPrint(response.error.toString());
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(loading: const Optional.value(true)));
          break;
      }
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  @override
  Future<void> close() async {
    await _authSubscription.cancel();
    return super.close();
  }
}
