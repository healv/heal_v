part of 'edit_profile_page_bloc.dart';

abstract class EditProfilePageEvent extends BaseEvent {
  const EditProfilePageEvent();

  factory EditProfilePageEvent.initial() => const Initial._();

  factory EditProfilePageEvent.avatarChanged({required String? avatar}) => AvatarChanged._(avatar: avatar);

  factory EditProfilePageEvent.firstNameChanged({required String? firstName}) => FirstNameChanged._(firstName: firstName);

  factory EditProfilePageEvent.emailChanged({required String? email}) => EmailChanged._(email: email);

  factory EditProfilePageEvent.lastNameChanged({required String? lastName}) => LastNameChanged._(lastName: lastName);

  factory EditProfilePageEvent.validateFirstName() => const ValidateFirstName._();

  factory EditProfilePageEvent.validateEmail() => const ValidateEmail._();

  factory EditProfilePageEvent.updateUser() => const UpdateUser._();

  factory EditProfilePageEvent.firstNameFocusChanged(bool isFocused) => FirstNameFocusChanged._(isFocused);

  factory EditProfilePageEvent.emailFocusChanged(bool isFocused) => EmailFocusChanged._(isFocused);

  factory EditProfilePageEvent.lastNameFocusChanged(bool isFocused) => LastNameFocusChanged._(isFocused);
}

final class Initial extends EditProfilePageEvent {
  const Initial._();
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

final class ValidateFirstName extends EditProfilePageEvent {
  const ValidateFirstName._();
}

final class ValidateEmail extends EditProfilePageEvent {
  const ValidateEmail._();
}

final class UpdateUser extends EditProfilePageEvent {
  const UpdateUser._();
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
