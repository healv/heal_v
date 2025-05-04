import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/profile/edit_profile/edit_profile_page_effect.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';

part 'edit_profile_page_event.dart';

part 'edit_profile_page_state.dart';

class EditProfilePageBloc extends SideEffectBloc<EditProfilePageEvent, EditProfilePageState, EditProfilePageSideEffect> {
  EditProfilePageBloc() : super(EditProfilePageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<AvatarChanged>(_handleAvatarChangedEvent);
    on<FirstNameChanged>(_handleFirstNameChangedEvent);
    on<LastNameChanged>(_handleLastNameChangedEvent);
    on<EmailChanged>(_handleEmailChangedEvent);
    on<BirthDateChanged>(_handleBirthDateChangedEvent);
    on<ValidateFirstName>(_handleValidateFirstNameEvent);
    on<ValidateEmail>(_handleValidateEmailEvent);
    on<FirstNameFocusChanged>(_handleFirstNameFocusChangedEvent);
    on<LastNameFocusChanged>(_handleLastNameFocusChangedEvent);
    on<EmailFocusChanged>(_handleEmailFocusChangedEvent);
    on<PasswordChanged>(_handlePasswordChangedEvent);
    on<UpdatePasswordVisibility>(_handleUpdatePasswordVisibilityEvent);
    on<Validate>(_handleValidateEvent);
    on<ValidatePassword>(_handleValidatePasswordEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<EditProfilePageState> emitter) async {
    emitter(state.copyWith(
      firstName: Optional.value(event.user.name),
      lastName: Optional.value(event.user.lastName),
      email: Optional.value(event.user.email),
      avatar: Optional.value(event.user.photoURL),
      birthDate: Optional.value(event.user.birthDate),
    ));
  }

  Future<void> _handleAvatarChangedEvent(AvatarChanged event, Emitter<EditProfilePageState> emitter) async {
    emitter(state.copyWith(avatar: Optional.value(event.avatar)));
  }

  Future<void> _handleFirstNameChangedEvent(FirstNameChanged event, Emitter<EditProfilePageState> emitter) async {
    emitter(state.copyWith(firstName: Optional.value(event.firstName)));
  }

  Future<void> _handleLastNameChangedEvent(LastNameChanged event, Emitter<EditProfilePageState> emitter) async {
    emitter(state.copyWith(lastName: Optional.value(event.lastName)));
  }

  Future<void> _handleEmailChangedEvent(EmailChanged event, Emitter<EditProfilePageState> emitter) async {
    emitter(state.copyWith(email: Optional.value(event.email)));
  }

  Future<void> _handleBirthDateChangedEvent(BirthDateChanged event, Emitter<EditProfilePageState> emitter) async {
    emitter(state.copyWith(birthDate: Optional.value(event.birthDate)));
  }

  Future<void> _handleValidateFirstNameEvent(ValidateFirstName event, Emitter<EditProfilePageState> emitter) async {
    EditProfilePageSideEffect.firstNameValidated(ResourceStatusEnum.loading);
    if (_validateFirstName()) {
      emitter(state.copyWith(firstNameErrorMsg: const Optional.value(null)));
      addSideEffect(EditProfilePageSideEffect.firstNameValidated(ResourceStatusEnum.success));
    } else {
      emitter(state.copyWith(firstNameErrorMsg: Optional.value(tr('this_field_is_required'))));
      addSideEffect(EditProfilePageSideEffect.firstNameValidated(ResourceStatusEnum.error));
    }
  }

  Future<void> _handleValidateEmailEvent(ValidateEmail event, Emitter<EditProfilePageState> emitter) async {
    EditProfilePageSideEffect.emailValidated(ResourceStatusEnum.loading);
    if (_validateEmail()) {
      emitter(state.copyWith(emailErrorMsg: const Optional.value(null)));
      addSideEffect(EditProfilePageSideEffect.emailValidated(ResourceStatusEnum.success));
    } else {
      emitter(state.copyWith(emailErrorMsg: Optional.value(tr('this_field_is_required'))));
      addSideEffect(EditProfilePageSideEffect.emailValidated(ResourceStatusEnum.error));
    }
  }

  Future<void> _handleValidatePasswordEvent(ValidatePassword event, Emitter<EditProfilePageState> emitter) async {
    EditProfilePageSideEffect.passwordValidated(ResourceStatusEnum.loading);
    if (_validatePassword()) {
      emitter(state.copyWith(passwordErrorMsg: const Optional.value(null)));
      addSideEffect(EditProfilePageSideEffect.passwordValidated(ResourceStatusEnum.success));
    } else {
      emitter(state.copyWith(passwordErrorMsg: Optional.value(tr('invalid_password'))));
      addSideEffect(EditProfilePageSideEffect.passwordValidated(ResourceStatusEnum.error));
    }
  }

  Future<void> _handleFirstNameFocusChangedEvent(FirstNameFocusChanged event, Emitter<EditProfilePageState> emitter) async {
    emitter(state.copyWith(isFirstNameFocused: event.isFocused));
  }

  Future<void> _handleLastNameFocusChangedEvent(LastNameFocusChanged event, Emitter<EditProfilePageState> emitter) async {
    emitter(state.copyWith(isLastNameFocused: event.isFocused));
  }

  Future<void> _handleEmailFocusChangedEvent(EmailFocusChanged event, Emitter<EditProfilePageState> emitter) async {
    emitter(state.copyWith(isEmailFocused: event.isFocused));
  }

  Future<void> _handlePasswordChangedEvent(PasswordChanged event, Emitter<EditProfilePageState> emitter) async {
    emitter(state.copyWith(password: Optional.value(event.password)));
  }

  Future<void> _handleUpdatePasswordVisibilityEvent(UpdatePasswordVisibility event, Emitter<EditProfilePageState> emitter) async {
    final isVisible = state.isPasswordHidden;
    emitter(state.copyWith(isPasswordHidden: !isVisible));
  }

  bool _validateFirstName() {
    final firstName = state.firstName?.trim();
    return firstName != null && firstName.isNotEmpty;
  }

  bool _validateEmail() {
    final firstName = state.email?.trim();
    return firstName != null && firstName.isNotEmpty;
  }

  bool _validatePassword() {
    final password = state.password?.trim();
    return password != null && password.length > 5;
  }

  Future<void> _handleValidateEvent(Validate event, Emitter<EditProfilePageState> emitter) async {
    EditProfilePageSideEffect.validated(ResourceStatusEnum.loading);
    if (!_validateEmail()) {
      emitter(state.copyWith(emailErrorMsg: Optional.value(tr('this_field_is_required'))));
      addSideEffect(EditProfilePageSideEffect.emailValidated(ResourceStatusEnum.error));
    } else {
      emitter(state.copyWith(emailErrorMsg: const Optional.value(null)));
      addSideEffect(EditProfilePageSideEffect.emailValidated(ResourceStatusEnum.success));
    }

    if (!_validateFirstName()) {
      emitter(state.copyWith(firstNameErrorMsg: Optional.value(tr('this_field_is_required'))));
      addSideEffect(EditProfilePageSideEffect.firstNameValidated(ResourceStatusEnum.error));
    } else {
      emitter(state.copyWith(firstNameErrorMsg: const Optional.value(null)));
      addSideEffect(EditProfilePageSideEffect.firstNameValidated(ResourceStatusEnum.success));
    }

    if (!_validatePassword()) {
      emitter(state.copyWith(passwordErrorMsg: Optional.value(tr('invalid_password'))));
      addSideEffect(EditProfilePageSideEffect.passwordValidated(ResourceStatusEnum.error));
    } else {
      emitter(state.copyWith(passwordErrorMsg: const Optional.value(null)));
      addSideEffect(EditProfilePageSideEffect.passwordValidated(ResourceStatusEnum.success));
    }

    if (state.emailErrorMsg == null && state.firstNameErrorMsg == null && state.passwordErrorMsg == null) {
      emitter(
        state.copyWith(
          firstNameErrorMsg: const Optional.value(null),
          emailErrorMsg: const Optional.value(null),
          passwordErrorMsg: const Optional.value(null),
        ),
      );
      addSideEffect(EditProfilePageSideEffect.validated(
        ResourceStatusEnum.success,
        name: state.firstName,
        lastName: state.lastName,
        email: state.email,
        birthDate: state.birthDate,
      ));
    } else {
      addSideEffect(EditProfilePageSideEffect.validated(ResourceStatusEnum.error));
    }
  }
}
