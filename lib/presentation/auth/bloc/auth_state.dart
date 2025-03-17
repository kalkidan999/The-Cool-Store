part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  auth,
  unauth,
  error,
}

final class AuthState extends Equatable {
  const AuthState._({
    this.status = AuthStatus.unauth,
    this.errorMessage = "",
    this.authToken = "",
  });

  final AuthStatus status;
  final String authToken;
  final String errorMessage;

  @override
  List<Object> get props => [status, authToken, errorMessage];

  const AuthState.initial() : this._(status: AuthStatus.initial);

  const AuthState.loading() : this._(status: AuthStatus.loading);

  const AuthState.unauth() : this._(status: AuthStatus.unauth);

  const AuthState.auth({required String authToken})
      : this._(status: AuthStatus.auth, authToken: authToken);

  const AuthState.error({required String errorMessage})
      : this._(status: AuthStatus.error, errorMessage: errorMessage);
}
