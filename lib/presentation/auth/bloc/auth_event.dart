part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String userName;
  final String password;

  const AuthLoginRequested({required this.userName, required this.password});
}

class LogouRequested extends AuthEvent {}
