part of 'edit_profile_page_bloc.dart';

abstract class EditProfilePageEvent extends BaseEvent {
  const EditProfilePageEvent();

  factory EditProfilePageEvent.initial({required UserDto user}) => Initial._(user);

  factory EditProfilePageEvent.avatarChanged({required String? avatar}) => AvatarChanged._(avatar: avatar);

  factory EditProfilePageEvent.firstNameChanged({required String? firstName}) => FirstNameChanged._(firstName: firstName);

  factory EditProfilePageEvent.birthDateChanged({required String? birthDate}) => BirthDateChanged._(birthDate: birthDate);

  factory EditProfilePageEvent.lastNameChanged({required String? lastName}) => LastNameChanged._(lastName: lastName);

  factory EditProfilePageEvent.validateFirstName() => const ValidateFirstName._();

  factory EditProfilePageEvent.firstNameFocusChanged(bool isFocused) => FirstNameFocusChanged._(isFocused);

  factory EditProfilePageEvent.lastNameFocusChanged(bool isFocused) => LastNameFocusChanged._(isFocused);

  factory EditProfilePageEvent.validate() => const Validate._();
}

final class Initial extends EditProfilePageEvent {
  final UserDto user;

  const Initial._(this.user);
}

final class AvatarChanged extends EditProfilePageEvent {
  final String? avatar;

  const AvatarChanged._({required this.avatar});
}

final class FirstNameChanged extends EditProfilePageEvent {
  final String? firstName;

  const FirstNameChanged._({required this.firstName});
}

final class LastNameChanged extends EditProfilePageEvent {
  final String? lastName;

  const LastNameChanged._({required this.lastName});
}

final class BirthDateChanged extends EditProfilePageEvent {
  final String? birthDate;

  const BirthDateChanged._({required this.birthDate});
}

final class ValidateFirstName extends EditProfilePageEvent {
  const ValidateFirstName._();
}

final class FirstNameFocusChanged extends EditProfilePageEvent {
  final bool isFocused;

  const FirstNameFocusChanged._(this.isFocused);
}

final class LastNameFocusChanged extends EditProfilePageEvent {
  final bool isFocused;

  const LastNameFocusChanged._(this.isFocused);
}

final class Validate extends EditProfilePageEvent {
  const Validate._();
}
