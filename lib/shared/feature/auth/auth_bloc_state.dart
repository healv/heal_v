part of 'auth_bloc.dart';

@immutable
final class AuthBlocState extends BaseState {
  final UserDto? user;
  final bool loading;

  const AuthBlocState._({
    this.user,
    this.loading = false,
  });

  factory AuthBlocState.initial() => const AuthBlocState._();

  @override
  List<Object?> get props => [user, loading];

  AuthBlocState copyWith({
    Optional<UserDto?>? user,
    Optional<bool?>? loading,
  }) {
    return AuthBlocState._(
      user: user?.isValid == true ? user?.value : this.user,
      loading: loading?.isValid == true ? loading?.value ?? false : this.loading,
    );
  }
}
