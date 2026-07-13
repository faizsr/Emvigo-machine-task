import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_repository.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({AuthRepository? repository})
      : _repository = repository ?? AuthRepository(),
        super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  final AuthRepository _repository;

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await _repository.loginWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthFailure(_errorMessage(e)));
    }
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await _repository.registerWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthFailure(_errorMessage(e)));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _repository.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(_errorMessage(e)));
    }
  }

  String _errorMessage(Object error) {
    return error.toString().replaceFirst('Exception: ', '');
  }
}
