import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<CheckAuth>(_onCheckAuth);
    on<SignInAuth>(_onSignInAuth);
    on<SignUpAuth>(_onSignUpAuth);
    on<SignOutAuth>(_onSignOutAuth);
  }

  void _onCheckAuth(CheckAuth event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 3));
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFail());
    }
  }

  void _onSignInAuth(SignInAuth event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 3));
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFail());
    }
  }

  void _onSignUpAuth(SignUpAuth event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 3));
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFail());
    }
  }

  void _onSignOutAuth(SignOutAuth event, Emitter<AuthState> emit) async {
    try {
      emit(AuthSignOut());
    } catch (e) {
      emit(AuthFail());
    }
  }
}
