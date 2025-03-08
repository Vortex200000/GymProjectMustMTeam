part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

class SignInLoading extends AuthState {}

class SignInSuccess extends AuthState {
  final UserCredential credential;
  SignInSuccess({required this.credential});
}

class SignInFailure extends AuthState {
  final String errorMessage;
  SignInFailure({required this.errorMessage});
}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {
  final UserCredential credential;
  SignUpSuccess({required this.credential});
}

class SignUpFailure extends AuthState {
  final String errorMessage;
  SignUpFailure({required this.errorMessage});
}

class UserNotLoggedIn extends AuthState {}
