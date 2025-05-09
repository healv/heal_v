part of 'auth_bloc.dart';

sealed class AuthBlocEvent extends BaseEvent {
  const AuthBlocEvent();

  factory AuthBlocEvent.initial() => Initial._();

  factory AuthBlocEvent.signIn({required String email, required String password}) => SignIn._(email: email, password: password);

  factory AuthBlocEvent.signInWithGoogle() => const SignInWithGoogle._();

  factory AuthBlocEvent.signUp({required String email, required String password, required String name, String? lastName}) => SignUp._(email: email, password: password, name: name, lastName: lastName);

  factory AuthBlocEvent.me(String? email, String? displayName) => GetMe._(email: email, displayName: displayName);

  factory AuthBlocEvent.updateUser(String? name, String? lastName, String? birthDate) => UpdateUser._(name: name, lastName: lastName, birthDate: birthDate);

  factory AuthBlocEvent.uploadImage(XFile xFile) => UploadImage._(xFile: xFile);

  factory AuthBlocEvent.logOut() => const LogOut._();

  factory AuthBlocEvent.changePassword(String currentPassword, String newPassword) => ChangePassword._(currentPassword: currentPassword, newPassword: newPassword);
}

class Initial extends AuthBlocEvent {
  Initial._();
}

class SignIn extends AuthBlocEvent {
  final String email;
  final String password;

  SignIn._({required this.email, required this.password});
}

class SignInWithGoogle extends AuthBlocEvent {
  const SignInWithGoogle._();
}

class SignUp extends AuthBlocEvent {
  final String email;
  final String password;
  final String name;
  final String? lastName;

  SignUp._({required this.email, required this.password, required this.name, this.lastName});
}

class GetMe extends AuthBlocEvent {
  final String? email;
  final String? displayName;

  GetMe._({this.email, this.displayName});
}

class UpdateUser extends AuthBlocEvent {
  final String? name;
  final String? lastName;
  final String? birthDate;

  UpdateUser._({required this.name, required this.lastName, required this.birthDate});
}

class UploadImage extends AuthBlocEvent {
  final XFile xFile;

  UploadImage._({required this.xFile});
}

class LogOut extends AuthBlocEvent {
  const LogOut._();
}

class ChangePassword extends AuthBlocEvent {
  final String currentPassword;
  final String newPassword;

  const ChangePassword._({required this.currentPassword, required this.newPassword});
}
