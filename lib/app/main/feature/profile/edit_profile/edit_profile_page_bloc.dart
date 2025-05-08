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
    on<BirthDateChanged>(_handleBirthDateChangedEvent);
    on<ValidateFirstName>(_handleValidateFirstNameEvent);
    on<FirstNameFocusChanged>(_handleFirstNameFocusChangedEvent);
    on<LastNameFocusChanged>(_handleLastNameFocusChangedEvent);
    on<Validate>(_handleValidateEvent);
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

  Future<void> _handleFirstNameFocusChangedEvent(FirstNameFocusChanged event, Emitter<EditProfilePageState> emitter) async {
    emitter(state.copyWith(isFirstNameFocused: event.isFocused));
  }

  Future<void> _handleLastNameFocusChangedEvent(LastNameFocusChanged event, Emitter<EditProfilePageState> emitter) async {
    emitter(state.copyWith(isLastNameFocused: event.isFocused));
  }

  bool _validateFirstName() {
    final firstName = state.firstName?.trim();
    return firstName != null && firstName.isNotEmpty;
  }

  Future<void> _handleValidateEvent(Validate event, Emitter<EditProfilePageState> emitter) async {
    EditProfilePageSideEffect.validated(ResourceStatusEnum.loading);

    if (!_validateFirstName()) {
      emitter(state.copyWith(firstNameErrorMsg: Optional.value(tr('this_field_is_required'))));
      addSideEffect(EditProfilePageSideEffect.firstNameValidated(ResourceStatusEnum.error));
    } else {
      emitter(state.copyWith(firstNameErrorMsg: const Optional.value(null)));
      addSideEffect(EditProfilePageSideEffect.firstNameValidated(ResourceStatusEnum.success));
    }

    if (state.firstNameErrorMsg == null) {
      emitter(state.copyWith(firstNameErrorMsg: const Optional.value(null)));
      addSideEffect(EditProfilePageSideEffect.validated(
        ResourceStatusEnum.success,
        name: state.firstName,
        lastName: state.lastName,
        birthDate: state.birthDate,
      ));
    } else {
      addSideEffect(EditProfilePageSideEffect.validated(ResourceStatusEnum.error));
    }
  }
}
