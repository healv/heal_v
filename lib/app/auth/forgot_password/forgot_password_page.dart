import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/auth/forgot_password/forgot_password_page_bloc.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/common/widgets/loading_elevated_button.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../common/flutter/widgets/framework.dart';
import '../../../../../common/tools/localization_tools.dart';
import '../../../../../common/utils/constants.dart';
import '../../../../../shared/feature/auth/auth_bloc.dart';
import '../../../../../shared/feature/auth/auth_bloc_effect.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends BlocDependentSideEffectState<ForgotPasswordPage, ForgotPasswordPageBloc, ForgotPasswordPageEffect> {
  final emailTextEditingController = TextEditingController();
  final emailFocusNode = FocusNode();
  StreamSubscription? _authEffectsSubscription;

  @override
  void initState() {
    super.initState();
    _authEffectsSubscription = context.read<AuthBloc>().sideEffects.listen(_listenAuthEffects);
    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        context.read<ForgotPasswordPageBloc>().add(ForgotPasswordPageEvent.emailChanged(emailTextEditingController.text));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ForgotPasswordPageBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<ForgotPasswordPageBloc, ForgotPasswordPageState>(
          listenWhen: (oldState, newState) => oldState.email != newState.email && emailTextEditingController.text != newState.email,
          listener: (context, state) {
            emailTextEditingController.text = state.email ?? emptyString;
          },
        ),
      ],
      child: Scaffold(
        body: _body(context, bloc),
      ),
    );
  }

  Widget _body(BuildContext context, ForgotPasswordPageBloc bloc) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          _logoImage(),
          const SizedBox(height: 32),
          _titleText(context),
          const SizedBox(height: 12),
          _descriptionText(context),
          const SizedBox(height: 32),
          _textFieldEmail(bloc),
          const SizedBox(height: 32),
          _buttonsRow(bloc),
        ],
      ),
    );
  }

  Widget _logoImage() {
    return Center(child: AppIcons.launcher.imageAsset());
  }

  Widget _titleText(BuildContext context) {
    return Text(
      tr('forgotYourPassword'),
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: context.onBackground,
        fontSize: 24.0,
      ),
    );
  }

  Widget _descriptionText(BuildContext context) {
    return Text(
      tr('enterYourEmailAddressAndWeWillSendYouALink'),
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: context.onBackground.withValues(alpha: 0.3),
        fontSize: 16.0,
      ),
    );
  }

  Widget _textFieldHeaderText(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: context.onBackground,
        fontSize: 12.0,
      ),
    );
  }

  Widget _textFieldEmail(ForgotPasswordPageBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textFieldHeaderText(context, tr('email')),
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<ForgotPasswordPageBloc, ForgotPasswordPageState>(
            buildWhen: (oldState, newState) => oldState.email != newState.email || oldState.emailErrorMsg != newState.emailErrorMsg,
            builder: (context, state) {
              return TextFormField(
                onTapOutside: (_) => context.unFocus(),
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                controller: emailTextEditingController,
                onChanged: (email) {
                  bloc.add(ForgotPasswordPageEvent.emailChanged(email));
                },
                keyboardType: TextInputType.text,
                cursorColor: context.onBackground,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  errorText: state.emailErrorMsg,
                  labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0, color: context.onBackground),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buttonsRow(ForgotPasswordPageBloc bloc) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              context.pop();
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: context.background,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: context.primary)),
              elevation: 0,
              minimumSize: const Size(129, 36),
            ),
            child: Text(tr('back'),
                style: TextStyle(
                  color: context.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                )),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: BlocSelector<ForgotPasswordPageBloc, ForgotPasswordPageState, bool>(
            selector: (ForgotPasswordPageState state) => state.isLoading,
            builder: (BuildContext context, bool isLoading) {
              return LoadingElevatedButton(
                  progressIndicatorColor: context.background,
                  isLoading: isLoading,
                  onPressed: () {
                    bloc.add(
                      ForgotPasswordPageEvent.validate(emailTextEditingController.text),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    minimumSize: const Size(129, 36),
                  ),
                  child: Text(tr('resetPassword'),
                      style: TextStyle(
                        color: context.background,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                      )));
            },
          ),
        ),
      ],
    );
  }

  _showSuccessSnackBar() {
    showTopSnackBar(
      Overlay.of(context),
      Material(
        color: Colors.transparent,
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: context.background,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: context.onBackground.withValues(alpha: 0.1),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: 8),
              AppIcons.checked.svgAsset(
                width: 48,
                height: 48,
                colorFilter: const ColorFilter.mode(Colors.green, BlendMode.srcIn),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${tr('success')}!',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tr('resetLinkSentToYourEmail'),
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                        color: context.onBackground.withValues(alpha: 0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listenAuthEffects(AuthBlocEffect effect) async {
    final bloc = context.read<ForgotPasswordPageBloc>();
    switch (effect) {
      case PasswordRecovered():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            _showSuccessSnackBar();
            context.pop();
            break;
          case ResourceStatusEnum.error:
            if (effect.errorMsg == userNotFound) {
              bloc.add(ForgotPasswordPageEvent.emailErrorMsgChanged(tr('noUserFoundForThatEmail')));
            } else {
              _showErrorSnackBar();
            }
            bloc.add(ForgotPasswordPageEvent.loadingStateChanged(false));
            break;
          case ResourceStatusEnum.loading:
            bloc.add(ForgotPasswordPageEvent.loadingStateChanged(true));
            break;
        }
        break;
      default:
        break;
    }
  }

  _showErrorSnackBar() {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(message: tr('somethingWentWrong')),
    );
  }

  @override
  Future<void> handleSideEffect(ForgotPasswordPageEffect effect) async {
    switch (effect) {
      case Validated():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            context.read<AuthBloc>().add(AuthBlocEvent.resetPassword(effect.email!));
            break;
          default:
            break;
        }
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailFocusNode.dispose();
    emailTextEditingController.dispose();
    _authEffectsSubscription?.cancel();
  }
}
