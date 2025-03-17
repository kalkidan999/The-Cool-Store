import 'package:bloc/bloc.dart';
import 'package:coolstore/core/error/error_handler.dart';
import 'package:coolstore/domain/usecases/auth_user.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUser authUser;
  AuthBloc({required this.authUser}) : super(AuthState.initial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AppStarted>(_onAppStarted);
    on<LogouRequested>(_onLogouRequested);
  }

  Future<void> _onAppStarted(
      AppStarted event, Emitter<AuthState> emitter) async {
    try {
      emit(AuthState.loading());
      final prefs = await SharedPreferences.getInstance();
      final authToken = prefs.getString('authToken');

      emit(authToken == null
          ? AuthState.unauth()
          : AuthState.auth(authToken: authToken));
    } catch (e) {
      emit(AuthState.error(errorMessage: e.toString()));
    }
  }

  Future<void> _onAuthLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emitter) async {
    try {
      emit(AuthState.loading());

      String token =
          await authUser(password: event.password, userName: event.userName);

      emit(AuthState.auth(authToken: token));
    } on ErrorHandler catch (e) {
      emit(AuthState.error(errorMessage: e.errorMessage.toString()));
    } catch (e) {
      emit(AuthState.error(errorMessage: e.toString()));
    }
  }

  Future<void> _onLogouRequested(
      LogouRequested event, Emitter<AuthState> emitter) async {
    try {
      emit(AuthState.loading());
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('authToken');

      emit(AuthState.unauth());
    } catch (e) {
      emit(AuthState.error(errorMessage: e.toString()));
    }
  }
}
