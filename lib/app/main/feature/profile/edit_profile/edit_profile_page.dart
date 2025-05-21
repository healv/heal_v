import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
import 'package:image_picker/image_picker.dart';

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
  final birthDateTextEditingController = TextEditingController();
  final ageTextEditingController = TextEditingController();
  StreamSubscription? _authEffectsSubscription;

  OverlayEntry? _overlayEntry;
  final GlobalKey _editIconKey = GlobalKey();

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
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final bloc = context.read<EditProfilePageBloc>();
    final authBloc = context.read<AuthBloc>();
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
                editIconKey: _editIconKey,
                onEditClick: () {
                  _overlayEntry == null ? _showPopover(authBloc) : _removePopover();
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

  void _showPopover(AuthBloc authBloc) {
    final renderBox = _editIconKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _removePopover,
            behavior: HitTestBehavior.translucent,
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Positioned(
            top: position.dy + 32,
            left: position.dx - position.dx / 2,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 265,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: context.onBackground.withValues(alpha: 0.1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: AppIcons.gallery.svgAsset(),
                      title: Text(
                        tr('chooseFromCameraRoll'),
                        style: TextStyle(
                          color: context.onBackground,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.2,
                        ),
                      ),
                      onTap: () {
                        _removePopover();
                        _pickImage(ImageSource.gallery, authBloc);
                      },
                    ),
                    ListTile(
                      leading: AppIcons.trash.svgAsset(),
                      title: Text(
                        tr('deleteCurrentPhoto'),
                        style: TextStyle(
                          color: context.primary,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.2,
                        ),
                      ),
                      onTap: () {
                        _removePopover();
                        authBloc.add(AuthBlocEvent.deleteImage());
                      }, // disabled
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
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
          const SizedBox(height: 16.0),
          _buttonsRow(bloc),
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
            buildWhen: (oldState, newState) =>
                oldState.firstNameErrorMsg != newState.firstNameErrorMsg || oldState.isFirstNameFocused != newState.isFirstNameFocused || oldState.firstName != newState.firstName,
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
          height: 48.0,
          child: AbsorbPointer(
            child: TextField(
              readOnly: true,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0),
              controller: emailTextEditingController,
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

  Widget _buttonsRow(EditProfilePageBloc bloc) {
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
          child: ElevatedButton(
            onPressed: () {
              bloc.add(EditProfilePageEvent.validate());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              minimumSize: const Size(129, 36),
            ),
            child: Text(tr('saveChanges'),
                style: TextStyle(
                  color: context.background,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                )),
          ),
        ),
      ],
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
      bloc.add(EditProfilePageEvent.birthDateChanged(birthDate: data.toIso8601String()));
    }
  }

  void _removePopover() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Future<String?> _pickImage(ImageSource imageSource, AuthBloc authBloc) async {
    final imagePicker = ImagePicker();
    try {
      final pickedFile = await imagePicker.pickImage(source: imageSource);
      if (pickedFile != null) {
        log('$healVTag pickedFile: ${pickedFile.path}');
        authBloc.add(AuthBlocEvent.uploadImage(pickedFile));
      }
    } catch (e) {
      log('Pick image failed:${e.toString()}');
    }
    return null;
  }

  @override
  Future<void> handleSideEffect(EditProfilePageSideEffect effect) async {
    switch (effect) {
      case Validated():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            context.read<AuthBloc>().add(AuthBlocEvent.updateUser(effect.name, effect.lastName, effect.birthDate));
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
            await showAlertDialog(title: tr('success'), message: tr('personalInformationUpdated'));
            if (!mounted) return;
            context.pop();
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
    _removePopover();
  }
}
