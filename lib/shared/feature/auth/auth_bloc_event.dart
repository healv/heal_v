part of 'auth_bloc.dart';

sealed class AuthBlocEvent extends BaseEvent {
  const AuthBlocEvent();

  factory AuthBlocEvent.initial() => Initial._();

  factory AuthBlocEvent.signIn({required String email, required String password}) => SignIn._(email: email, password: password);

  factory AuthBlocEvent.signInFirebase({required String uid, required String email, required String displayName}) => SignInFirebase._(uid: uid, email: email, displayName: displayName);

  factory AuthBlocEvent.signUp({required String email, required String password, required String name, String? lastName}) => SignUp._(email: email, password: password, name: name, lastName: lastName);

  factory AuthBlocEvent.me({required String accessToken}) => GetMe._(accessToken: accessToken);
}

class Initial extends AuthBlocEvent {
  Initial._();
}

class SignIn extends AuthBlocEvent {
  final String email;
  final String password;

  SignIn._({required this.email, required this.password});
}

class SignInFirebase extends AuthBlocEvent {
  final String uid;
  final String email;
  final String displayName;

  SignInFirebase._({required this.uid, required this.email, required this.displayName});
}

class SignUp extends AuthBlocEvent {
  final String email;
  final String password;
  final String name;
  final String? lastName;

  SignUp._({required this.email, required this.password, required this.name, this.lastName});
}

class GetMe extends AuthBlocEvent {
  final String accessToken;

  GetMe._({required this.accessToken});
}
