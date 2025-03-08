import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mgym/core/usecase/base_use_case.dart';
import 'package:mgym/features/domain/use_cases/auth/is_user_loged_in_use_case.dart';
import 'package:mgym/features/domain/use_cases/auth/log_email_password.dart';
import 'package:mgym/features/domain/use_cases/auth/sign_out_use_case.dart';
import 'package:mgym/features/domain/use_cases/auth/sign_up_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthBloc get(context) => BlocProvider.of(context);

  final LoginEmailAndPasswordUseCase _loginemailAndPasswordUseCase;
  final SignUpEmailAndPasswordUseCase _signUpemailAndPasswordUseCase;
  final CheckIfUserLoggedInUseCase _checkUserLoggedInUsecCase;
  final SignOutUseCase _signOutUseCase;
  AuthBloc(
      this._loginemailAndPasswordUseCase,
      this._signUpemailAndPasswordUseCase,
      this._checkUserLoggedInUsecCase,
      this._signOutUseCase)
      : super(AuthInitial()) {
    on<SignInEmailAndPasswordEvent>(_signIn);
    on<SignUpEmailAndPasswordEvent>(_signUp);
    on<CheckUserLoggedInEvent>(_checkLogin);
    on<SignOutEvent>(_signOut);
  }

  Future<void> _signIn(
      SignInEmailAndPasswordEvent event, Emitter<AuthState> emit) async {
    emit(SignInLoading());
    final result = await _loginemailAndPasswordUseCase
        .call(AuthParameters(email: event.email, password: event.password));

    result.fold(
      (failure) {
        emit(SignInFailure(errorMessage: failure.message));
      },
      (userCreds) {
        emit(SignInSuccess(credential: userCreds));
      },
    );
  }

  Future<void> _checkLogin(
      CheckUserLoggedInEvent event, Emitter<AuthState> emit) async {
    emit(CheckUserLoggedLoading());
    await Future.delayed(const Duration(seconds: 3));

    final isLoggedIn =
        await _checkUserLoggedInUsecCase.call(const NoParameters());
    isLoggedIn.fold(
      (fail) {
        emit(CheckUserLoggedInError(errorMessage: fail.message));
      },
      (user) {
        if (user != null) {
          emit(CheckUserLoggedSuccess(user: user));
        } else {
          emit(UserNotLoggedIn());
        }
      },
    );
  }

  Future<void> _signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(SignOutLoading());
    final result = await _signOutUseCase.call(const NoParameters());
    result.fold(
      (failure) {
        emit(SignOutFailure(errorMessage: failure.message));
      },
      (success) {
        emit(SignOutSuccess());
      },
    );
  }

  Future<void> _signUp(
      SignUpEmailAndPasswordEvent event, Emitter<AuthState> emit) async {
    emit(SignUpLoading());
    final result = await _signUpemailAndPasswordUseCase
        .call(AuthParameters(email: event.email, password: event.password));

    result.fold(
      (failure) {
        emit(SignUpFailure(errorMessage: failure.message));
      },
      (userCreds) {
        emit(SignUpSuccess(credential: userCreds));
      },
    );
  }
}

AuthBloc authBloc(BuildContext context) => AuthBloc.get(context);
