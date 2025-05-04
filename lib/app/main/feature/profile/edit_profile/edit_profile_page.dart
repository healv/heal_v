import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/profile/edit_profile/edit_profile_page_bloc.dart';
import 'package:heal_v/app/main/feature/profile/edit_profile/edit_profile_page_effect.dart';
import 'package:heal_v/common/extensions/date_time_extension.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/tools/sound_player.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/avatar_widget.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../../common/flutter/widgets/framework.dart' show BlocDependentSideEffectState;
import '../../../../../common/utils/alert.dart';
import '../../../../../common/utils/resource.dart';
import '../../../../../shared/feature/auth/auth_bloc_effect.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends BlocDependentSideEffectState<EditProfilePage, EditProfilePageBloc, EditProfilePageSideEffect> {
  final firstNameTextEditingController = TextEditingController();
  final firstNameFocusNode = FocusNode();
  final lastNameTextEditingController = TextEditingController();
  final lastNameFocusNode = FocusNode();
  final emailTextEditingController = TextEditingController();
  final emailFocusNode = FocusNode();
  final birthDateTextEditingController = TextEditingController();
  final ageTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final passwordFocusNode = FocusNode();
  StreamSubscription? _authEffectsSubscription;

  @override
  void initState() {
    super.initState();
    _authEffectsSubscription = context.read<AuthBloc>().sideEffects.listen(_listenAuthEffects);
    firstNameFocusNode.addListener(() {
      context.read<EditProfilePageBloc>().add(EditProfilePageEvent.firstNameFocusChanged(firstNameFocusNode.hasFocus));
      if (!firstNameFocusNode.hasFocus) {
        context.read<EditProfilePageBloc>().add(EditProfilePageEvent.validateFirstName());
      }
    });
    lastNameFocusNode.addListener(() {
      context.read<EditProfilePageBloc>().add(EditProfilePageEvent.lastNameFocusChanged(lastNameFocusNode.hasFocus));
    });
    emailFocusNode.addListener(() {
      context.read<EditProfilePageBloc>().add(EditProfilePageEvent.emailFocusChanged(emailFocusNode.hasFocus));
      if (!emailFocusNode.hasFocus) {
        context.read<EditProfilePageBloc>().add(EditProfilePageEvent.validateEmail());
      }
    });
    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        context.read<EditProfilePageBloc>().add(EditProfilePageEvent.validatePassword());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textAlign: TextAlign.center,
          tr('edit_profile'),
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: context.onBackground,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              context.read<EditProfilePageBloc>().add(EditProfilePageEvent.validate());
            },
            child: AppIcons.editProfileSave.svgAsset(),
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      // appBar: HealVAppBar.simple(title: tr('edit_profile'), isBackEnable: true),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final bloc = context.read<EditProfilePageBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<EditProfilePageBloc, EditProfilePageState>(
          listenWhen: (oldState, newState) => oldState.firstName != newState.firstName && firstNameTextEditingController.text != newState.firstName,
          listener: (context, state) {
            firstNameTextEditingController.text = state.firstName ?? emptyString;
          },
        ),
        BlocListener<EditProfilePageBloc, EditProfilePageState>(
          listenWhen: (oldState, newState) => oldState.lastName != newState.lastName && lastNameTextEditingController.text != newState.lastName,
          listener: (context, state) {
            lastNameTextEditingController.text = state.lastName ?? emptyString;
          },
        ),
        BlocListener<EditProfilePageBloc, EditProfilePageState>(
          listenWhen: (oldState, newState) => oldState.email != newState.email && emailTextEditingController.text != newState.email,
          listener: (context, state) {
            emailTextEditingController.text = state.email ?? emptyString;
          },
        ),
        BlocListener<EditProfilePageBloc, EditProfilePageState>(
          listenWhen: (oldState, newState) => oldState.birthDate != newState.birthDate && birthDateTextEditingController.text != newState.birthDate,
          listener: (context, state) {
            birthDateTextEditingController.text = DateTime.tryParse(state.birthDate ?? emptyString).ddMMYYYY();
            ageTextEditingController.text = (DateTime.now().year - DateTime.tryParse(state.birthDate ?? emptyString)!.year).toString();
          },
        ),
      ],
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              AvatarWidget(
                onEditClick: () {
                  //todo need to handle
                },
              ),
              const SizedBox(height: 8.0),
              _firstTextFieldsContainer(bloc),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstTextFieldsContainer(EditProfilePageBloc bloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _textFieldFirstName(),
          const SizedBox(height: 8.0),
          _textFieldLastName(),
          const SizedBox(height: 8.0),
          _textFieldEmail(),
          const SizedBox(height: 8.0),
          _textFieldAge(),
          const SizedBox(height: 8.0),
          _textFieldBirth(bloc),
          const SizedBox(height: 8.0),
          _textFieldPassword(bloc),
        ],
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

  Widget _textFieldFirstName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textFieldHeaderText(context, tr('name')),
        const SizedBox(height: 6),
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<EditProfilePageBloc, EditProfilePageState>(
            buildWhen: (oldState, newState) => oldState.firstNameErrorMsg != newState.firstNameErrorMsg || oldState.isFirstNameFocused != newState.isFirstNameFocused || oldState.firstName != newState.firstName,
            builder: (BuildContext context, EditProfilePageState state) {
              return TextField(
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                controller: firstNameTextEditingController,
                focusNode: firstNameFocusNode,
                onChanged: (changedFirstName) {
                  context.read<EditProfilePageBloc>().add(EditProfilePageEvent.firstNameChanged(firstName: changedFirstName));
                },
                textCapitalization: TextCapitalization.words,
                cursorColor: context.onBackground,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(12)),
                  errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(12)),
                  suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                  suffixIcon: state.isFirstNameFocused && state.firstName?.isNotEmpty == true
                      ? InkWell(
                          onTap: () {
                            firstNameTextEditingController.text = emptyString;
                            context.read<EditProfilePageBloc>().add(EditProfilePageEvent.firstNameChanged(firstName: emptyString));
                          },
                          child: _textFieldCloseIcon(),
                        )
                      : null,
                  hintText: state.firstName?.isNotEmpty != true ? tr('first_name') : emptyString,
                  errorText: state.firstNameErrorMsg,
                  hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _textFieldLastName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textFieldHeaderText(context, tr('last_name')),
        const SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<EditProfilePageBloc, EditProfilePageState>(
            buildWhen: (oldState, newState) => oldState.isLastNameFocused != newState.isLastNameFocused || oldState.lastName != newState.lastName,
            builder: (context, state) {
              return TextField(
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                controller: lastNameTextEditingController,
                focusNode: lastNameFocusNode,
                onChanged: (changedLastName) {
                  context.read<EditProfilePageBloc>().add(EditProfilePageEvent.lastNameChanged(lastName: changedLastName));
                },
                textCapitalization: TextCapitalization.words,
                cursorColor: context.onBackground,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(12)),
                  errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(12)),
                  suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                  suffixIcon: state.isLastNameFocused && state.lastName?.isNotEmpty == true
                      ? InkWell(
                          onTap: () {
                            lastNameTextEditingController.text = emptyString;
                            context.read<EditProfilePageBloc>().add(EditProfilePageEvent.lastNameChanged(lastName: emptyString));
                          },
                          child: _textFieldCloseIcon(),
                        )
                      : null,
                  hintText: state.lastName?.isNotEmpty != true ? tr('last_name') : emptyString,
                  hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _textFieldEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textFieldHeaderText(context, tr('email')),
        const SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<EditProfilePageBloc, EditProfilePageState>(
            buildWhen: (oldState, newState) => oldState.isEmailFocused != newState.isEmailFocused || oldState.email != newState.email || oldState.emailErrorMsg != newState.emailErrorMsg,
            builder: (context, state) {
              return TextField(
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                controller: emailTextEditingController,
                focusNode: emailFocusNode,
                onChanged: (changedEmail) {
                  context.read<EditProfilePageBloc>().add(EditProfilePageEvent.emailChanged(email: changedEmail));
                },
                textCapitalization: TextCapitalization.words,
                cursorColor: context.onBackground,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(12)),
                  errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(12)),
                  suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                  suffixIcon: state.isEmailFocused && state.email?.isNotEmpty == true
                      ? InkWell(
                          onTap: () {
                            emailTextEditingController.text = emptyString;
                            context.read<EditProfilePageBloc>().add(EditProfilePageEvent.emailChanged(email: emptyString));
                          },
                          child: _textFieldCloseIcon(),
                        )
                      : null,
                  hintText: state.email?.isNotEmpty != true ? tr('email') : emptyString,
                  errorText: state.emailErrorMsg,
                  hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _textFieldBirth(EditProfilePageBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textFieldHeaderText(context, tr('birth')),
        const SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          height: 48.0,
          child: BlocBuilder<EditProfilePageBloc, EditProfilePageState>(
            buildWhen: (oldState, newState) => oldState.birthDate != newState.birthDate,
            builder: (context, state) {
              return InkWell(
                onTap: () => _openCalendar(state.birthDate ?? emptyString, bloc),
                child: AbsorbPointer(
                  child: TextField(
                    readOnly: true,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                    controller: birthDateTextEditingController,
                    textCapitalization: TextCapitalization.words,
                    cursorColor: context.onBackground,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _textFieldAge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textFieldHeaderText(context, tr('age')),
        const SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          height: 48.0,
          child: AbsorbPointer(
            child: TextField(
              readOnly: true,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
              controller: ageTextEditingController,
              textCapitalization: TextCapitalization.words,
              cursorColor: context.onBackground,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textFieldPassword(EditProfilePageBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textFieldHeaderText(context, tr('password')),
        const SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<EditProfilePageBloc, EditProfilePageState>(
            buildWhen: (oldState, newState) => oldState.password != newState.password || oldState.passwordErrorMsg != newState.passwordErrorMsg || oldState.isPasswordHidden != newState.isPasswordHidden,
            builder: (context, state) {
              return TextFormField(
                focusNode: passwordFocusNode,
                onTapOutside: (_) => context.unFocus(),
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
                controller: passwordTextEditingController,
                onChanged: (password) {
                  bloc.add(EditProfilePageEvent.passwordChanged(password: password));
                },
                keyboardType: TextInputType.text,
                cursorColor: context.onBackground,
                obscureText: state.isPasswordHidden,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: context.onBackground.withValues(alpha: 0.3)), borderRadius: BorderRadius.circular(12)),
                  errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(12)),
                  focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(12)),
                  suffixIconConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
                  errorText: state.passwordErrorMsg,
                  hintText: tr('password'),
                  hintStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0, color: context.onBackground),
                  suffixIcon: IconButton(
                    icon: Icon(
                      state.isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                      color: context.onBackground.withValues(alpha: 0.6),
                    ),
                    onPressed: () {
                      bloc.add(EditProfilePageEvent.updatePasswordVisibility());
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
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

  Future<void> _openCalendar(String birthDate, EditProfilePageBloc bloc) async {
    final birthDateDateTime = DateTime.tryParse(birthDate);
    await SoundPlayer.checkAndPlayClickSound();
    final data = await showDatePicker(
      context: context.mounted ? context : throw Exception("Don't use BuildContext's across async gaps "),
      initialDate: birthDateDateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (data != null && data != birthDateDateTime) {
      bloc.add(EditProfilePageEvent.birthDateChanged(birthDate: data.toUtc().toIso8601String()));
    }
  }

  @override
  Future<void> handleSideEffect(EditProfilePageSideEffect effect) async {
    switch (effect) {
      case Validated():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            context.read<AuthBloc>().add(AuthBlocEvent.updateUser(effect.name, effect.lastName, effect.email, effect.birthDate));
            break;
          default:
            break;
        }
      default:
        break;
    }
  }

  void _listenAuthEffects(AuthBlocEffect effect) async {
    switch (effect) {
      case UserUpdated():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            showAlertDialog(title: tr('success'), message: effect.errorMsg.toString());
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
  void dispose() {
    super.dispose();
    _authEffectsSubscription?.cancel();
    firstNameTextEditingController.dispose();
    lastNameTextEditingController.dispose();
    emailTextEditingController.dispose();
    birthDateTextEditingController.dispose();
    ageTextEditingController.dispose();
    passwordTextEditingController.dispose();
  }
}
