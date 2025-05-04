part of 'edit_profile_page_bloc.dart';

abstract class EditProfilePageEvent extends BaseEvent {
  const EditProfilePageEvent();

  factory EditProfilePageEvent.initial({required UserDto user}) => Initial._(user);

  factory EditProfilePageEvent.avatarChanged({required String? avatar}) => AvatarChanged._(avatar: avatar);

  factory EditProfilePageEvent.firstNameChanged({required String? firstName}) => FirstNameChanged._(firstName: firstName);

  factory EditProfilePageEvent.emailChanged({required String? email}) => EmailChanged._(email: email);

  factory EditProfilePageEvent.birthDateChanged({required String? birthDate}) => BirthDateChanged._(birthDate: birthDate);

  factory EditProfilePageEvent.lastNameChanged({required String? lastName}) => LastNameChanged._(lastName: lastName);

  factory EditProfilePageEvent.validateFirstName() => const ValidateFirstName._();

  factory EditProfilePageEvent.validateEmail() => const ValidateEmail._();

  factory EditProfilePageEvent.validatePassword() => const ValidatePassword._();

  factory EditProfilePageEvent.firstNameFocusChanged(bool isFocused) => FirstNameFocusChanged._(isFocused);

  factory EditProfilePageEvent.emailFocusChanged(bool isFocused) => EmailFocusChanged._(isFocused);

  factory EditProfilePageEvent.lastNameFocusChanged(bool isFocused) => LastNameFocusChanged._(isFocused);

  factory EditProfilePageEvent.passwordChanged({required String password}) => PasswordChanged._(password: password);

  factory EditProfilePageEvent.updatePasswordVisibility() => const UpdatePasswordVisibility._();

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

final class EmailChanged extends EditProfilePageEvent {
  final String? email;

  const EmailChanged._({required this.email});
}

final class BirthDateChanged extends EditProfilePageEvent {
  final String? birthDate;

  const BirthDateChanged._({required this.birthDate});
}

final class ValidateFirstName extends EditProfilePageEvent {
  const ValidateFirstName._();
}

final class ValidateEmail extends EditProfilePageEvent {
  const ValidateEmail._();
}

final class ValidatePassword extends EditProfilePageEvent {
  const ValidatePassword._();
}

final class FirstNameFocusChanged extends EditProfilePageEvent {
  final bool isFocused;

  const FirstNameFocusChanged._(this.isFocused);
}

final class LastNameFocusChanged extends EditProfilePageEvent {
  final bool isFocused;

  const LastNameFocusChanged._(this.isFocused);
}

final class EmailFocusChanged extends EditProfilePageEvent {
  final bool isFocused;

  const EmailFocusChanged._(this.isFocused);
}

final class PasswordChanged extends EditProfilePageEvent {
  final String? password;

  const PasswordChanged._({required this.password});
}

final class UpdatePasswordVisibility extends EditProfilePageEvent {
  const UpdatePasswordVisibility._();
}

final class Validate extends EditProfilePageEvent {
  const Validate._();
}
