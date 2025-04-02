import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/profile/edit_profile/edit_profile_page_bloc.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/tools/sound_player.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/common/widgets/avatar_widget.dart';
import 'package:heal_v/theme/ext/extension.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final firstNameTextEditingController = TextEditingController();
  final firstNameFocusNode = FocusNode();
  final lastNameTextEditingController = TextEditingController();
  final lastNameFocusNode = FocusNode();
  final emailTextEditingController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HealVAppBar.simple(title: tr('edit_profile'), isBackEnable: true),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
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
      ],
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32.0),
              const AvatarWidget(isEditable: false),
              const SizedBox(height: 32.0),
              _firstTextFieldsContainer(),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstTextFieldsContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _textFieldFirstName(),
          const SizedBox(height: 24.0),
          _textFieldLastName(),
          const SizedBox(height: 24.0),
          _textFieldEmail(),
          const SizedBox(height: 24.0),
          _birthDayWidget(),
          const SizedBox(height: 32.0),
          _editButton(),
        ],
      ),
    );
  }

  Widget _textFieldHeaderText(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        color: context.textSecondary,
        fontSize: 12.0,
      ),
    );
  }

  Widget _textFieldFirstName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textFieldHeaderText(context, tr('first_name')),
        const SizedBox(height: 4),
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
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: context.onBackground.withOpacity(0.3))),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: context.primary)),
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
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: context.onBackground.withOpacity(0.3))),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: context.primary)),
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
            buildWhen: (oldState, newState) => oldState.isEmailFocused != newState.isEmailFocused || oldState.email != newState.email,
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
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: context.onBackground.withOpacity(0.3))),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: context.primary)),
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

  Widget _birthDayWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr('age'), style: TextStyle(fontSize: 12, color: context.textSecondary, fontWeight: FontWeight.w400)),
            const SizedBox(height: 8),
            Text("23", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: context.onBackground)),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () async => await _openCalendar(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tr('birth'), style: TextStyle(fontSize: 12, color: context.textSecondary, fontWeight: FontWeight.w400)),
              const SizedBox(height: 4),
              Text("3/2/2001", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: context.onBackground)),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _editButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: () {}, child: Text(tr('edit'))),
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

  Future<void> _openCalendar() async {
    await SoundPlayer.checkAndPlayClickSound();
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }
}
