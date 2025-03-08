import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withOpacity(0.3))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.primary)),
                    errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                    suffixIcon: state.isEmailFocused && state.email?.isNotEmpty == true
                        ? InkWell(
                            onTap: () {
                              emailTextEditingController.text = emptyString;
                              context.read<SignInPageBloc>().add(SignInPageEvent.emailChanged(email: emptyString));
                            },
                            child: _textFieldCloseIcon(),
                          )
                        : null,
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
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withOpacity(0.3))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.primary)),
                    errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                    suffixIcon: state.isPasswordFocused && state.password?.isNotEmpty == true
                        ? InkWell(
                            onTap: () {
                              passwordEditingController.text = emptyString;
                              context.read<SignInPageBloc>().add(SignInPageEvent.passwordChanged(password: emptyString));
                            },
                            child: _textFieldCloseIcon(),
                          )
                        : null,
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
    return IconButton(
      onPressed: () {},
      icon: AppIcons.google.svgAsset(height: 40),
    );
  }

  Widget _textFieldCloseIcon() {
    return SizedBox(
      width: 8.0,
      height: 8.0,
      child: Icon(
        Icons.clear_sharp,
        color: context.onBackground,
        size: 15.0,
      ),
    );
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
