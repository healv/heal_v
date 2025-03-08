part of 'auth_bloc.dart';

@immutable
final class AuthBlocState extends BaseState {
  final String? accessToken;
  final User? user;
  final bool loading;

  const AuthBlocState._({
    this.accessToken,
    this.user,
    this.loading = false,
  });

  factory AuthBlocState.initial() => const AuthBlocState._();

  @override
  List<Object?> get props => [accessToken, user, loading];

  AuthBlocState copyWith({
    Optional<String?>? accessToken,
    Optional<User?>? user,
    Optional<bool?>? loading,
  }) {
    return AuthBlocState._(
      accessToken: accessToken?.isValid == true ? accessToken?.value : this.accessToken,
      user: user?.isValid == true ? user?.value : this.user,
      loading: loading?.isValid == true ? loading?.value ?? false : this.loading,
    );
  }
}
