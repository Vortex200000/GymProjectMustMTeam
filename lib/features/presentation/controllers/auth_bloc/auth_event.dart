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
