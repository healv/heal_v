part of 'auth_bloc.dart';

@immutable
final class AuthBlocState extends BaseState {
  final String? accessToken;
  final User? user;

  const AuthBlocState._({
    this.accessToken,
    this.user,
  });

  factory AuthBlocState.initial() => const AuthBlocState._();

  @override
  List<Object?> get props => [accessToken, user];

  AuthBlocState copyWith({
    Optional<String?>? accessToken,
    Optional<User?>? user,
  }) {
    return AuthBlocState._(
      accessToken: accessToken?.isValid == true ? accessToken?.value : this.accessToken,
      user: user?.isValid == true ? user?.value : this.user,
    );
  }
}
