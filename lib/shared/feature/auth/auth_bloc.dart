import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
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
import 'package:heal_v/feature/heal_v/api/auth/packet/update_user_packet.dart';
import 'package:heal_v/feature/heal_v/api/auth/repo/auth_repo.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc_effect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
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
    on<UpdateUser>(_handleUpdateUserEvent);
    on<UploadImage>(_handleUploadImageEvent);
    on<LogOut>(_handleLogOutEvent);
  }

  Future<void> _subscribeToFirebaseUser() async {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) async {
      log('$healVTag authStateChanges: user: $user');
      if (state.user != null && user == null) {
        add(AuthBlocEvent.logOut());
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

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        add(AuthBlocEvent.me(user.email, user.displayName));
      } else {
        addSideEffect(AuthBlocEffect.notLoggedIn());
      }
    } on FirebaseAuthException catch (error) {
      log('$healVTag authorizationError: $error');
      add(AuthBlocEvent.logOut());
    } catch (e) {
      log('$healVTag authorizationError: $e');
      add(AuthBlocEvent.logOut());
    }
    _subscribeToFirebaseUser();
  }

  Future<void> _handleSignInEvent(SignIn event, Emitter<AuthBlocState> emitter) async {
    try {
      emitter(state.copyWith(loading: const Optional.value(true)));
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: event.email, password: event.password);
      log('$healVTag isNewUser: ${userCredential.additionalUserInfo?.isNewUser}');
      if (userCredential.user != null) {
        add(AuthBlocEvent.me(userCredential.user?.email, userCredential.user?.displayName));
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
        add(AuthBlocEvent.me(userCredential.user?.email, userCredential.user?.displayName));
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
        add(AuthBlocEvent.me(userCredentials.user?.email, '${event.name} ${event.lastName}'));
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
  }

  Future<void> _handleMeEvent(GetMe event, Emitter<AuthBlocState> emitter) async {
    await for (final response in repo.getMe(event.email, event.displayName)) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(user: Optional.value(response.data), loading: const Optional.value(false)));
          addSideEffect(AuthBlocEffect.loggedIn(ResourceStatusEnum.success));
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(loading: const Optional.value(false)));
          add(AuthBlocEvent.logOut());
          debugPrint(response.error.toString());
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(loading: const Optional.value(true)));
          break;
      }
    }
  }

  Future<void> _handleUpdateUserEvent(UpdateUser event, Emitter<AuthBlocState> emitter) async {
    if (event.name != state.user?.name || state.user?.lastName != event.lastName || state.user?.birthDate != event.birthDate) {
      await for (final response in repo.updateUser(UpdateUserPacket(name: event.name, lastName: event.lastName, birthDate: event.birthDate))) {
        switch (response.status) {
          case ResourceStatusEnum.success:
            emitter(state.copyWith(user: Optional.value(response.data), loading: const Optional.value(false)));
            addSideEffect(AuthBlocEffect.userUpdated(ResourceStatusEnum.success));
            break;
          case ResourceStatusEnum.error:
            emitter(state.copyWith(loading: const Optional.value(false)));
            addSideEffect(AuthBlocEffect.userUpdated(ResourceStatusEnum.error));
            debugPrint(response.error.toString());
            break;
          case ResourceStatusEnum.loading:
            emitter(state.copyWith(loading: const Optional.value(true)));
            break;
        }
      }
    }
  }

  Future<void> _handleUploadImageEvent(UploadImage event, Emitter<AuthBlocState> emitter) async {
    final type = lookupMimeType(event.xFile.path);
    final data = FormData();
    data.files.add(MapEntry(
      'image',
      MultipartFile.fromFileSync(
        event.xFile.path,
        filename: event.xFile.path.split(Platform.pathSeparator).last,
        contentType: DioMediaType.parse(type ?? emptyString),
      ),
    ));
    await for (final response in repo.uploadImage(data)) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(user: const Optional.value(null)));
          emitter(state.copyWith(user: Optional.value(response.data), loading: const Optional.value(false)));
          addSideEffect(AuthBlocEffect.imageUploaded(ResourceStatusEnum.success));
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(loading: const Optional.value(false)));
          addSideEffect(AuthBlocEffect.imageUploaded(ResourceStatusEnum.error));
          debugPrint(response.error.toString());
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(loading: const Optional.value(true)));
          break;
      }
    }
  }

  Future<void> _handleLogOutEvent(LogOut event, Emitter<AuthBlocState> emitter) async {
    try {
      if (FirebaseAuth.instance.currentUser?.providerData.first.providerId == 'google.com') {
        await GoogleSignIn().signOut();
      }
      await FirebaseAuth.instance.signOut();
      emitter(state.copyWith(loading: const Optional.value(false), user: const Optional.value(null)));
      addSideEffect(AuthBlocEffect.loggedOut(ResourceStatusEnum.success));
    } catch (e) {
      log('$healVTag logout error: ${e.toString()}');
    }
  }

  @override
  Future<void> close() async {
    await _authSubscription.cancel();
    return super.close();
  }
}
