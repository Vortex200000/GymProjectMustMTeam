part of 'auth_bloc.dart';

sealed class AuthEvent {}

class SignInEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  SignInEmailAndPasswordEvent(this.email, this.password);
}

class SignUpEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  SignUpEmailAndPasswordEvent(this.email, this.password);
}

class SignOutEvent extends AuthEvent {}

class CheckUserLoggedInEvent extends AuthEvent {}

class CheckUserLoggedLoading extends AuthState {}

class CheckUserLoggedSuccess extends AuthState {
  final User user;
  CheckUserLoggedSuccess({required this.user});
}

class CheckUserLoggedInError extends AuthState {
  final String errorMessage;
  CheckUserLoggedInError({required this.errorMessage});
}

class SignOutLoading extends AuthState {}

class SignOutSuccess extends AuthState {}

class SignOutFailure extends AuthState {
  final String errorMessage;
  SignOutFailure({required this.errorMessage});
}
