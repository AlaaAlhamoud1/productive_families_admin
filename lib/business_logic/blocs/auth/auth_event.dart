part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class CheckAuth extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignInAuth extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignUpAuth extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignOutAuth extends AuthEvent {
  @override
  List<Object?> get props => [];
}