import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/core/usecase/base_use_case.dart';
import 'package:mgym/features/domain/main_reposetories/auth_main_repo.dart';

class LoginEmailAndPasswordUseCase
    extends BaseUseCase<UserCredential, AuthParameters> {
  final AuthMainRepo _repo;
  LoginEmailAndPasswordUseCase(this._repo);
  @override
  Future<Either<Failure, UserCredential>> call(AuthParameters param) {
    return _repo.loginEmailAndPassword(param);
  }
}

class AuthParameters extends Equatable {
  final String email;
  final String password;

  const AuthParameters({required this.email, required this.password});

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
