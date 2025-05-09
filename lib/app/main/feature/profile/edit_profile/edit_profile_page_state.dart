part of 'edit_profile_page_bloc.dart';

@immutable
class EditProfilePageState extends BaseState {
  final String? avatar;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? birthDate;
  final String? firstNameErrorMsg;
  final bool isFirstNameFocused;
  final bool isLastNameFocused;

  const EditProfilePageState._({
    this.avatar,
    this.firstName,
    this.lastName,
    this.email,
    this.birthDate,
    this.firstNameErrorMsg,
    this.isFirstNameFocused = false,
    this.isLastNameFocused = false,
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
      ];

  EditProfilePageState copyWith({
    Optional<String?>? avatar,
    Optional<String?>? firstName,
    Optional<String?>? lastName,
    Optional<String?>? email,
    Optional<String?>? birthDate,
    Optional<String?>? firstNameErrorMsg,
    bool? isFirstNameFocused,
    bool? isLastNameFocused,
  }) {
    return EditProfilePageState._(
      avatar: avatar?.isValid == true ? avatar?.value : this.avatar,
      firstName: firstName?.isValid == true ? firstName?.value : this.firstName,
      lastName: lastName?.isValid == true ? lastName?.value : this.lastName,
      email: email?.isValid == true ? email?.value : this.email,
      birthDate: birthDate?.isValid == true ? birthDate?.value : this.birthDate,
      firstNameErrorMsg: firstNameErrorMsg?.isValid == true ? firstNameErrorMsg?.value : this.firstNameErrorMsg,
      isFirstNameFocused: isFirstNameFocused ?? this.isFirstNameFocused,
      isLastNameFocused: isLastNameFocused ?? this.isLastNameFocused,
    );
  }
}
