import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/features/domain/main_reposetories/auth_main_repo.dart';
import 'package:mgym/features/domain/use_cases/auth/log_email_password.dart';

import '../../../../core/usecase/base_use_case.dart';

class SignUpEmailAndPasswordUseCase
    extends BaseUseCase<UserCredential, AuthParameters> {
  final AuthMainRepo _repo;
  SignUpEmailAndPasswordUseCase(this._repo);
  @override
  Future<Either<Failure, UserCredential>> call(AuthParameters param) async {
    return await _repo.signUpEmailAndPassword(param);
  }
}
