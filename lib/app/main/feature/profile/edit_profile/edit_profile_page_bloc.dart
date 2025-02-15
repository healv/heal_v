import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/profile/edit_profile/edit_profile_page_effect.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/resource.dart';

part 'edit_profile_page_event.dart';

part 'edit_profile_page_state.dart';

class EditProfilePageBloc extends SideEffectBloc<EditProfilePageEvent, EditProfilePageState, EditProfilePageSideEffect> {
  EditProfilePageBloc() : super(EditProfilePageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<AvatarChanged>(_handleAvatarChangedEvent);
    on<FirstNameChanged>(_handleFirstNameChangedEvent);
    on<LastNameChanged>(_handleLastNameChangedEvent);
    on<EmailChanged>(_handleEmailChangedEvent);
    on<ValidateFirstName>(_handleValidateFirstNameEvent);
    on<ValidateEmail>(_handleValidateEmailEvent);
    on<UpdateUser>(_handleUpdateUserEvent);
    on<FirstNameFocusChanged>(_handleFirstNameFocusChangedEvent);
    on<LastNameFocusChanged>(_handleLastNameFocusChangedEvent);
    on<EmailFocusChanged>(_handleEmailFocusChangedEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<EditProfilePageState> emitter) async {
    emitter(state.copyWith(
      firstName: const Optional.value('Emma'), // event.user?.firstName
      lastName: const Optional.value('Elhadedy'), // event.user?.lastName
      email: const Optional.value('emanelhadidi777@gmail.com'), // event.user?.email
      avatar: const Optional.value(''), // event.user?.avatar
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

  Future<void> _handleUpdateUserEvent(UpdateUser event, Emitter<EditProfilePageState> emitter) async {
    EditProfilePageSideEffect.validated(ResourceStatusEnum.loading);
    if (_validateFirstName()) {
      emitter(state.copyWith(firstNameErrorMsg: const Optional.value(null)));
      addSideEffect(EditProfilePageSideEffect.validated(ResourceStatusEnum.success));
    } else {
      emitter(state.copyWith(firstNameErrorMsg: Optional.value(tr('this_field_is_required'))));
      addSideEffect(EditProfilePageSideEffect.validated(ResourceStatusEnum.error));
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

  bool _validateFirstName() {
    final firstName = state.firstName?.trim();
    return firstName != null && firstName.isNotEmpty;
  }

  bool _validateEmail() {
    final firstName = state.email?.trim();
    return firstName != null && firstName.isNotEmpty;
  }
}
