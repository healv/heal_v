import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/auth/sign_up/sign_up_page_bloc.dart';
import 'package:heal_v/app/auth/sign_up/sign_up_page_effect.dart';
import 'package:heal_v/common/flutter/widgets/framework.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/alert.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/common/widgets/loading_elevated_button.dart';
import 'package:heal_v/navigation/main/home/home_graph.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc_effect.dart';
import 'package:heal_v/theme/ext/extension.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends BlocDependentSideEffectState<SignUpPage, SignUpPageBloc, SignUpPageSideEffect> {
  final firstNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final repeatPasswordEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().sideEffects.listen(_listenAuthEffects);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('sign_up'),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: context.onBackground),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: AppIcons.arrowLeft.svgAsset(),
        ),
        leadingWidth: 40,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            _textFieldFirstName(),
            const SizedBox(height: 16),
            _textFieldLastName(),
            const SizedBox(height: 16),
            _textFieldEmail(),
            const SizedBox(height: 16),
            _textFieldPassword(),
            const SizedBox(height: 16),
            _textFieldRepeatPassword(),
            const SizedBox(height: 24.0),
            _signUpButton(context),
            const SizedBox(height: 20),
            Text(tr('or_sign_up_with')),
            const SizedBox(height: 10),
            _googleSignUpIcon(context),
          ],
        ),
      ),
    );
  }

  Widget _textFieldFirstName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<SignUpPageBloc, SignUpPageState>(
              builder: (context, state) {
                return TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                  controller: firstNameTextEditingController,
                  onChanged: (firstName) {
                    context.read<SignUpPageBloc>().add(SignUpPageEvent.firstNameChanged(firstName: firstName));
                  },
                  keyboardType: TextInputType.text,
                  cursorColor: context.onBackground,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withOpacity(0.3))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.primary)),
                    errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                    errorText: state.firstNameErrorMsg,
                    labelText: tr('first_name'),
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

  Widget _textFieldLastName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<SignUpPageBloc, SignUpPageState>(
              builder: (context, state) {
                return TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                  controller: lastNameTextEditingController,
                  onChanged: (lastName) {
                    context.read<SignUpPageBloc>().add(SignUpPageEvent.lastNameChanged(lastName: lastName));
                  },
                  keyboardType: TextInputType.text,
                  cursorColor: context.onBackground,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withOpacity(0.3))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.primary)),
                    errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                    labelText: tr('last_name'),
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

  Widget _textFieldEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<SignUpPageBloc, SignUpPageState>(
              builder: (context, state) {
                return TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                  controller: emailTextEditingController,
                  onChanged: (email) {
                    context.read<SignUpPageBloc>().add(SignUpPageEvent.emailChanged(email: email));
                  },
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: context.onBackground,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withOpacity(0.3))),
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
            child: BlocBuilder<SignUpPageBloc, SignUpPageState>(
              builder: (context, state) {
                return TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                  controller: passwordEditingController,
                  onChanged: (password) {
                    context.read<SignUpPageBloc>().add(SignUpPageEvent.passwordChanged(password: password));
                  },
                  keyboardType: TextInputType.text,
                  cursorColor: context.onBackground,
                  obscureText: state.isPasswordHidden,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withOpacity(0.3))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.primary)),
                    errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                    errorText: state.passwordErrorMsg,
                    labelText: tr('password'),
                    labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0, color: context.onBackground),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                        color: context.onBackground.withOpacity(0.6),
                      ),
                      onPressed: () {
                        context.read<SignUpPageBloc>().add(SignUpPageEvent.updatePasswordVisibility());
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFieldRepeatPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<SignUpPageBloc, SignUpPageState>(
              builder: (context, state) {
                return TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                  controller: repeatPasswordEditingController,
                  onChanged: (password) {
                    context.read<SignUpPageBloc>().add(SignUpPageEvent.repeatPasswordChanged(password: password));
                  },
                  keyboardType: TextInputType.text,
                  cursorColor: context.onBackground,
                  obscureText: state.isRepeatPasswordHidden,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withOpacity(0.3))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.primary)),
                    errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                    errorText: state.repeatPasswordErrorMsg,
                    labelText: tr('repeat_password'),
                    labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0, color: context.onBackground),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isRepeatPasswordHidden ? Icons.visibility : Icons.visibility_off,
                        color: context.onBackground.withOpacity(0.6),
                      ),
                      onPressed: () {
                        context.read<SignUpPageBloc>().add(SignUpPageEvent.updateRepeatPasswordVisibility());
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _signUpButton(BuildContext context) {
    return BlocSelector<AuthBloc, AuthBlocState, bool>(
      selector: (state) => state.loading == true,
      builder: (context, loading) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: LoadingElevatedButton(
            progressIndicatorColor: Colors.white,
            isLoading: loading,
            onPressed: () {
              context.read<SignUpPageBloc>().add(SignUpPageEvent.validate());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primary,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(tr('sign_up').toUpperCase(), style: const TextStyle(color: Colors.white)),
          ),
        );
      },
    );
  }

  Widget _googleSignUpIcon(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: AppIcons.google.svgAsset(height: 40),
    );
  }

  void _listenAuthEffects(AuthBlocEffect effect) async {
    switch (effect) {
      case SignedUp():
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
  Future<void> handleSideEffect(SignUpPageSideEffect effect) async {
    switch (effect) {
      case Validated():
        context.read<AuthBloc>().add(
              AuthBlocEvent.signUp(
                email: emailTextEditingController.text,
                password: passwordEditingController.text,
                name: firstNameTextEditingController.text,
              ),
            );
        break;
    }
  }
}
