import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/auth/sign_in/sign_in_page_bloc.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailTextEditingController = TextEditingController();
  final emailFocusNode = FocusNode();

  final passwordEditingController = TextEditingController();
  final passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() {
      context.read<SignInPageBloc>().add(SignInPageEvent.emailFocusChanged(isFocused: emailFocusNode.hasFocus));
      if (!emailFocusNode.hasFocus) {
        context.read<SignInPageBloc>().add(SignInPageEvent.validateEmail());
      }
    });

    passwordFocusNode.addListener(() {
      context.read<SignInPageBloc>().add(SignInPageEvent.passwordFocusChanged(isFocused: passwordFocusNode.hasFocus));
      if (!passwordFocusNode.hasFocus) {
        context.read<SignInPageBloc>().add(SignInPageEvent.validatePassword());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignInPageBloc, SignInPageState>(
          listenWhen: (oldState, newState) => oldState.email != newState.email && emailTextEditingController.text != newState.email,
          listener: (context, state) {
            emailTextEditingController.text = state.email ?? emptyString;
          },
        ),
        BlocListener<SignInPageBloc, SignInPageState>(
          listenWhen: (oldState, newState) => oldState.password != newState.password && passwordEditingController.text != newState.password,
          listener: (context, state) {
            passwordEditingController.text = state.password ?? emptyString;
          },
        ),
      ],
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 120),
              AppIcons.launcher.imageAsset(width: 100, height: 100),
              const SizedBox(height: 32),
              _textFieldEmail(),
              const SizedBox(height: 16),
              _textFieldPassword(),
            ],
          ),
        ),
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
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                  controller: emailTextEditingController,
                  focusNode: emailFocusNode,
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
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                  controller: passwordEditingController,
                  focusNode: passwordFocusNode,
                  onChanged: (password) {
                    context.read<SignInPageBloc>().add(SignInPageEvent.passwordChanged(password: password));
                  },
                  keyboardType: TextInputType.text,
                  cursorColor: context.onBackground,
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
}
