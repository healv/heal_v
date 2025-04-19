import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:heal_v/app/auth/sign_in/sign_in_page_bloc.dart';
import 'package:heal_v/app/auth/sign_in/sign_in_page_effect.dart';
import 'package:heal_v/common/flutter/widgets/framework.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/alert.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/common/widgets/loading_elevated_button.dart';
import 'package:heal_v/navigation/auth/auth_graph.dart';
import 'package:heal_v/navigation/main/home/home_graph.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc_effect.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends BlocDependentSideEffectState<SignInPage, SignInPageBloc, SignInPageSideEffect> {
  final emailTextEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().sideEffects.listen(_listenAuthEffects);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            AppIcons.launcher.imageAsset(width: 120, height: 120),
            const SizedBox(height: 32),
            _signInText(context),
            const SizedBox(height: 16),
            _textFieldEmail(),
            const SizedBox(height: 16),
            _textFieldPassword(),
            const SizedBox(height: 8),
            _forgotPasswordTextButton(context),
            const SizedBox(height: 24.0),
            _signInButton(context),
            const SizedBox(height: 10.0),
            _signUpButton(context),
            const SizedBox(height: 20),
            Text(tr('or_login_with')),
            const SizedBox(height: 10),
            _googleSignInIcon(context),
          ],
        ),
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(tr('sign_in'), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: context.onBackground)),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<SignInPageBloc, SignInPageState>(
              builder: (context, state) {
                return TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                  controller: emailTextEditingController,
                  onChanged: (email) {
                    context.read<SignInPageBloc>().add(SignInPageEvent.emailChanged(email: email));
                  },
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: context.onBackground,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.primary)),
                    errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                    errorText: state.emailErrorMsg,
                    labelText: tr('email'),
                    labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0, color: context.onBackground),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFieldPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<SignInPageBloc, SignInPageState>(
              builder: (context, state) {
                return TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                  controller: passwordEditingController,
                  onChanged: (password) {
                    context.read<SignInPageBloc>().add(SignInPageEvent.passwordChanged(password: password));
                  },
                  keyboardType: TextInputType.text,
                  cursorColor: context.onBackground,
                  obscureText: state.isPasswordHidden,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.primary)),
                    errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                        color: context.onBackground.withValues(alpha: 0.6),
                      ),
                      onPressed: () {
                        context.read<SignInPageBloc>().add(SignInPageEvent.updatePasswordVisibility());
                      },
                    ),
                    errorText: state.passwordErrorMsg,
                    labelText: tr('password'),
                    labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0, color: context.onBackground),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _forgotPasswordTextButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {},
          child: Text(tr('forgot_password')),
        ),
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
    return BlocSelector<AuthBloc, AuthBlocState, bool>(
      selector: (state) => state.loading == true,
      builder: (context, loading) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: LoadingElevatedButton(
            progressIndicatorColor: Colors.white,
            isLoading: loading,
            onPressed: () {
              context.read<SignInPageBloc>().add(SignInPageEvent.validate());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primary,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(tr('sign_in').toUpperCase(), style: const TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }

  Widget _signUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: OutlinedButton(
        onPressed: () {
          SignUpRoute().push(context);
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(tr('sign_up').toUpperCase(), style: TextStyle(color: context.primary)),
      ),
    );
  }

  Widget _googleSignInIcon(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 60,
          child: IconButton(
            onPressed: () async {
              final userCredential = await _signInWithGoogle();
              log("GOOGLE_SIGN_IN_TAG: User credentials:$userCredential");
              if (userCredential?.user?.uid != null && userCredential?.user?.email != null && userCredential?.user?.displayName != null) {
                authBloc.add(
                  AuthBlocEvent.signInFirebase(
                    uid: userCredential?.user?.uid ?? emptyString,
                    email: userCredential?.user?.email ?? emptyString,
                    displayName: userCredential?.user?.displayName ?? emptyString,
                  ),
                );
              }
            },
            icon: AppIcons.google.svgAsset(height: 35),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
        if (Platform.isIOS) const SizedBox(width: 8.0),
        if (Platform.isIOS)
          SizedBox(
            height: 60,
            child: IconButton(
              onPressed: () async {
                final userCredential = await _signInWithApple();
              },
              icon: const Icon(Icons.apple, size: 50),
              padding: const EdgeInsets.only(bottom: 4.0),
              constraints: const BoxConstraints(),
            ),
          ),
      ],
    );
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      debugPrint("Error Google: $error");
      return null;
    }
  }

  Future<UserCredential?> _signInWithApple() async {
    try {
      if (!Platform.isIOS && !Platform.isMacOS) {
        debugPrint("Apple Sign-In support only for iOS/macOS");
        return null;
      }

      final AuthorizationCredentialAppleID appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );

      final OAuthCredential credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      debugPrint("Error Apple: $error");
      return null;
    }
  }

  void _listenAuthEffects(AuthBlocEffect effect) async {
    switch (effect) {
      case LoggedIn():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            HomeRoute().go(context);
            break;
          case ResourceStatusEnum.error:
            showAlertDialog(title: tr('error'), message: effect.errorMsg.toString());
            break;
          default:
            break;
        }
      default:
        break;
    }
  }

  @override
  Future<void> handleSideEffect(SignInPageSideEffect effect) async {
    switch (effect) {
      case Validated():
        context.read<AuthBloc>().add(AuthBlocEvent.signIn(email: emailTextEditingController.text, password: passwordEditingController.text));
        break;
    }
  }
}
