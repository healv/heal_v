part of 'auth_bloc.dart';

sealed class AuthBlocEvent extends BaseEvent {
  const AuthBlocEvent();

  factory AuthBlocEvent.initial() => Initial._();

  factory AuthBlocEvent.logout() => Logout._();
}

final class Initial extends AuthBlocEvent {
  Initial._();
}

final class Logout extends AuthBlocEvent {
  Logout._();
}
