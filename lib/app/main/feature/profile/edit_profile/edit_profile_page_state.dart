part of 'edit_profile_page_bloc.dart';

@immutable
class EditProfilePageState extends BaseState {
  final String? avatar;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? firstNameErrorMsg;
  final String? emailErrorMsg;
  final bool isFirstNameFocused;
  final bool isLastNameFocused;
  final bool isEmailFocused;

  const EditProfilePageState._({
    this.avatar,
    this.firstName,
    this.lastName,
    this.email,
    this.firstNameErrorMsg,
    this.emailErrorMsg,
    this.isFirstNameFocused = false,
    this.isLastNameFocused = false,
    this.isEmailFocused = false,
  });

  factory EditProfilePageState.initial() => const EditProfilePageState._();

  @override
  List<Object?> get props => [avatar, firstName, lastName, email, firstNameErrorMsg, isFirstNameFocused, isLastNameFocused, isEmailFocused, emailErrorMsg];

  EditProfilePageState copyWith({
    Optional<String?>? avatar,
    Optional<String?>? firstName,
    Optional<String?>? lastName,
    Optional<String?>? email,
    Optional<String?>? firstNameErrorMsg,
    Optional<String?>? emailErrorMsg,
    bool? isFirstNameFocused,
    bool? isLastNameFocused,
    bool? isEmailFocused,
  }) {
    return EditProfilePageState._(
      avatar: avatar?.isValid == true ? avatar?.value : this.avatar,
      firstName: firstName?.isValid == true ? firstName?.value : this.firstName,
      lastName: lastName?.isValid == true ? lastName?.value : this.lastName,
      email: email?.isValid == true ? email?.value : this.email,
      firstNameErrorMsg: firstNameErrorMsg?.isValid == true ? firstNameErrorMsg?.value : this.firstNameErrorMsg,
      emailErrorMsg: emailErrorMsg?.isValid == true ? emailErrorMsg?.value : this.emailErrorMsg,
      isFirstNameFocused: isFirstNameFocused ?? this.isFirstNameFocused,
      isLastNameFocused: isLastNameFocused ?? this.isLastNameFocused,
      isEmailFocused: isEmailFocused ?? this.isEmailFocused,
    );
  }
}
