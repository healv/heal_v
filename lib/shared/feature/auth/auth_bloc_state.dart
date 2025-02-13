part of 'auth_bloc.dart';

@immutable
final class AuthBlocState extends BaseState {
  final String? accessToken;

  const AuthBlocState._({
    this.accessToken,
  });

  factory AuthBlocState.initial() => const AuthBlocState._();

  @override
  List<Object?> get props => [accessToken];

  AuthBlocState copyWith({
    Optional<String?>? accessToken,
  }) {
    return AuthBlocState._(
      accessToken: accessToken?.isValid == true ? accessToken?.value : this.accessToken,
    );
  }
}
