part of 'edit_profile_page_bloc.dart';

@immutable
class EditProfilePageState extends BaseState {
  final String? avatar;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? birthDate;
  final String? firstNameErrorMsg;
  final String? emailErrorMsg;
  final bool isFirstNameFocused;
  final bool isLastNameFocused;
  final bool isEmailFocused;
  final String? password;
  final String? passwordErrorMsg;
  final bool isPasswordHidden;

  const EditProfilePageState._({
    this.avatar,
    this.firstName,
    this.lastName,
    this.email,
    this.birthDate,
    this.firstNameErrorMsg,
    this.emailErrorMsg,
    this.isFirstNameFocused = false,
    this.isLastNameFocused = false,
    this.isEmailFocused = false,
    this.password,
    this.passwordErrorMsg,
    this.isPasswordHidden = true,
  });

  factory EditProfilePageState.initial() => const EditProfilePageState._();

  @override
  List<Object?> get props => [
        avatar,
        firstName,
        lastName,
        email,
        birthDate,
        firstNameErrorMsg,
        isFirstNameFocused,
        isLastNameFocused,
        isEmailFocused,
        emailErrorMsg,
        password,
        passwordErrorMsg,
        isPasswordHidden,
      ];

  EditProfilePageState copyWith({
    Optional<String?>? avatar,
    Optional<String?>? firstName,
    Optional<String?>? lastName,
    Optional<String?>? email,
    Optional<String?>? birthDate,
    Optional<String?>? firstNameErrorMsg,
    Optional<String?>? emailErrorMsg,
    bool? isFirstNameFocused,
    bool? isLastNameFocused,
    bool? isEmailFocused,
    Optional<String?>? password,
    Optional<String?>? passwordErrorMsg,
    bool? isPasswordHidden,
  }) {
    return EditProfilePageState._(
      avatar: avatar?.isValid == true ? avatar?.value : this.avatar,
      firstName: firstName?.isValid == true ? firstName?.value : this.firstName,
      lastName: lastName?.isValid == true ? lastName?.value : this.lastName,
      email: email?.isValid == true ? email?.value : this.email,
      birthDate: birthDate?.isValid == true ? birthDate?.value : this.birthDate,
      firstNameErrorMsg: firstNameErrorMsg?.isValid == true ? firstNameErrorMsg?.value : this.firstNameErrorMsg,
      emailErrorMsg: emailErrorMsg?.isValid == true ? emailErrorMsg?.value : this.emailErrorMsg,
      isFirstNameFocused: isFirstNameFocused ?? this.isFirstNameFocused,
      isLastNameFocused: isLastNameFocused ?? this.isLastNameFocused,
      isEmailFocused: isEmailFocused ?? this.isEmailFocused,
      password: password?.isValid == true ? password?.value : this.password,
      passwordErrorMsg: passwordErrorMsg?.isValid == true ? passwordErrorMsg?.value : this.passwordErrorMsg,
      isPasswordHidden: isPasswordHidden ?? this.isPasswordHidden,
    );
  }
}
