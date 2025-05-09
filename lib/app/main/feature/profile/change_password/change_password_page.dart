import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/profile/change_password/change_password_page_bloc.dart';
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

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends BlocDependentSideEffectState<ChangePasswordPage, ChangePasswordPageBloc, ChangePasswordPageSideEffect> {
  final currentPasswordTextEditingController = TextEditingController();
  final currentPasswordFocusNode = FocusNode();
  final newPasswordTextEditingController = TextEditingController();
  final newPasswordFocusNode = FocusNode();
  final confirmNewPasswordTextEditingController = TextEditingController();
  final confirmNewPasswordFocusNode = FocusNode();
  StreamSubscription? _authEffectsSubscription;

  @override
  void initState() {
    super.initState();
    _authEffectsSubscription = context.read<AuthBloc>().sideEffects.listen(_listenAuthEffects);
    currentPasswordFocusNode.addListener(() {
      if (!currentPasswordFocusNode.hasFocus) {
        context.read<ChangePasswordPageBloc>().add(ChangePasswordPageEvent.currentPasswordChanged(currentPasswordTextEditingController.text));
      }
    });
    newPasswordFocusNode.addListener(() {
      if (!newPasswordFocusNode.hasFocus) {
        context.read<ChangePasswordPageBloc>().add(ChangePasswordPageEvent.newPasswordChanged(newPasswordTextEditingController.text));
      }
    });
    confirmNewPasswordFocusNode.addListener(() {
      if (!confirmNewPasswordFocusNode.hasFocus) {
        context.read<ChangePasswordPageBloc>().add(ChangePasswordPageEvent.confirmNewPasswordChanged(confirmNewPasswordTextEditingController.text));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChangePasswordPageBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<ChangePasswordPageBloc, ChangePasswordPageState>(
          listenWhen: (oldState, newState) => oldState.currentPassword != newState.currentPassword && currentPasswordTextEditingController.text != newState.currentPassword,
          listener: (context, state) {
            currentPasswordTextEditingController.text = state.currentPassword ?? emptyString;
          },
        ),
        BlocListener<ChangePasswordPageBloc, ChangePasswordPageState>(
          listenWhen: (oldState, newState) => oldState.newPassword != newState.newPassword && newPasswordTextEditingController.text != newState.newPassword,
          listener: (context, state) {
            newPasswordTextEditingController.text = state.newPassword ?? emptyString;
          },
        ),
        BlocListener<ChangePasswordPageBloc, ChangePasswordPageState>(
          listenWhen: (oldState, newState) => oldState.confirmNewPassword != newState.confirmNewPassword && confirmNewPasswordTextEditingController.text != newState.confirmNewPassword,
          listener: (context, state) {
            confirmNewPasswordTextEditingController.text = state.confirmNewPassword ?? emptyString;
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            textAlign: TextAlign.center,
            tr('changePassword'),
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: context.onBackground,
            ),
          ),
        ),
        body: _body(context, bloc),
        bottomNavigationBar: _buttonsRow(bloc),
      ),
    );
  }

  Widget _body(BuildContext context, ChangePasswordPageBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        _textFieldCurrentPassword(bloc),
        const SizedBox(height: 16),
        _textFieldNewPassword(bloc),
        const SizedBox(height: 16),
        _textFieldConfirmNewPassword(bloc),
      ],
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

  Widget _textFieldCurrentPassword(ChangePasswordPageBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textFieldHeaderText(context, tr('currentPassword')),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<ChangePasswordPageBloc, ChangePasswordPageState>(
              buildWhen: (oldState, newState) =>
                  oldState.currentPassword != newState.currentPassword ||
                  oldState.currentPasswordErrorMsg != newState.currentPasswordErrorMsg ||
                  oldState.isCurrentPasswordHidden != newState.isCurrentPasswordHidden,
              builder: (context, state) {
                return TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                  controller: currentPasswordTextEditingController,
                  onChanged: (password) {
                    bloc.add(ChangePasswordPageEvent.currentPasswordChanged(password));
                  },
                  keyboardType: TextInputType.text,
                  cursorColor: context.onBackground,
                  obscureText: state.isCurrentPasswordHidden,
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
                    suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isCurrentPasswordHidden ? Icons.visibility : Icons.visibility_off,
                        color: context.onBackground.withValues(alpha: 0.6),
                      ),
                      onPressed: () {
                        bloc.add(ChangePasswordPageEvent.currentPasswordVisibilityChanged());
                      },
                    ),
                    errorText: state.currentPasswordErrorMsg,
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

  Widget _textFieldNewPassword(ChangePasswordPageBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textFieldHeaderText(context, tr('newPassword')),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<ChangePasswordPageBloc, ChangePasswordPageState>(
              buildWhen: (oldState, newState) =>
                  oldState.newPassword != newState.newPassword || oldState.newPasswordErrorMsg != newState.newPasswordErrorMsg || oldState.isNewPasswordHidden != newState.isNewPasswordHidden,
              builder: (context, state) {
                return TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                  controller: newPasswordTextEditingController,
                  onChanged: (password) {
                    bloc.add(ChangePasswordPageEvent.newPasswordChanged(password));
                  },
                  keyboardType: TextInputType.text,
                  cursorColor: context.onBackground,
                  obscureText: state.isNewPasswordHidden,
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
                    suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isNewPasswordHidden ? Icons.visibility : Icons.visibility_off,
                        color: context.onBackground.withValues(alpha: 0.6),
                      ),
                      onPressed: () {
                        bloc.add(ChangePasswordPageEvent.newPasswordVisibilityChanged());
                      },
                    ),
                    errorText: state.newPasswordErrorMsg,
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

  Widget _textFieldConfirmNewPassword(ChangePasswordPageBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textFieldHeaderText(context, tr('confirmYourNewPassword')),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: BlocBuilder<ChangePasswordPageBloc, ChangePasswordPageState>(
              buildWhen: (oldState, newState) =>
                  oldState.confirmNewPassword != newState.confirmNewPassword ||
                  oldState.confirmNewPasswordErrorMsg != newState.confirmNewPasswordErrorMsg ||
                  oldState.isConfirmNewPasswordHidden != newState.isConfirmNewPasswordHidden,
              builder: (context, state) {
                return TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                  controller: confirmNewPasswordTextEditingController,
                  onChanged: (password) {
                    bloc.add(ChangePasswordPageEvent.confirmNewPasswordChanged(password));
                  },
                  keyboardType: TextInputType.text,
                  cursorColor: context.onBackground,
                  obscureText: state.isConfirmNewPasswordHidden,
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
                    suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isConfirmNewPasswordHidden ? Icons.visibility : Icons.visibility_off,
                        color: context.onBackground.withValues(alpha: 0.6),
                      ),
                      onPressed: () {
                        bloc.add(ChangePasswordPageEvent.confirmNewPasswordVisibilityChanged());
                      },
                    ),
                    errorText: state.confirmNewPasswordErrorMsg,
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

  Widget _buttonsRow(ChangePasswordPageBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
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
              child: Text(tr('cancel'),
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
            child: BlocSelector<ChangePasswordPageBloc, ChangePasswordPageState, bool>(
              selector: (ChangePasswordPageState state) => state.isLoading,
              builder: (BuildContext context, bool isLoading) {
                return LoadingElevatedButton(
                    progressIndicatorColor: context.background,
                    isLoading: isLoading,
                    onPressed: () {
                      bloc.add(
                        ChangePasswordPageEvent.validate(
                          currentPasswordTextEditingController.text,
                          newPasswordTextEditingController.text,
                          confirmNewPasswordTextEditingController.text,
                        ),
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
                    child: Text(tr('save'),
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
      ),
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
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tr('yourPasswordHasBeenChanged'),
                      style: TextStyle(
                        fontSize: 14.0,
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
    final changePasswordPageBloc = context.read<ChangePasswordPageBloc>();
    switch (effect) {
      case PasswordChanged():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            _showSuccessSnackBar();
            context.pop();
            break;
          case ResourceStatusEnum.error:
            if (effect.errorMsg == wrongPassword) {
              changePasswordPageBloc.add(ChangePasswordPageEvent.currentPasswordErrorMsgChanged(tr('wrongPassword')));
            } else {
              _showErrorSnackBar();
            }
            changePasswordPageBloc.add(ChangePasswordPageEvent.loadingStateChanged(false));
            break;
          case ResourceStatusEnum.loading:
            changePasswordPageBloc.add(ChangePasswordPageEvent.loadingStateChanged(true));
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
      CustomSnackBar.error(
        message: tr('somethingWentWrong'),
      ),
    );
  }

  @override
  Future<void> handleSideEffect(ChangePasswordPageSideEffect effect) async {
    switch (effect) {
      case Validated():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            context.read<AuthBloc>().add(AuthBlocEvent.changePassword(effect.currentPassword!, effect.newPassword!));
            break;
          default:
            break;
        }
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    currentPasswordFocusNode.dispose();
    currentPasswordTextEditingController.dispose();
    newPasswordFocusNode.dispose();
    newPasswordTextEditingController.dispose();
    confirmNewPasswordFocusNode.dispose();
    confirmNewPasswordTextEditingController.dispose();
    _authEffectsSubscription?.cancel();
  }
}
