import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/core/helpers/my_repos_helper.dart';
import 'package:mgym/features/data/data_source/remote_data/auth_remote_data/auth_remote_data.dart';
import 'package:mgym/features/domain/main_reposetories/auth_main_repo.dart';
import 'package:mgym/features/domain/use_cases/auth/log_email_password.dart';

class AuthRebo extends AuthMainRepo {
  final AuthRemoteData _auth;
  AuthRebo(this._auth);

  @override
  Future<Either<Failure, UserCredential>> loginEmailAndPassword(
      AuthParameters params) async {
    return executeOperation(
      () => _auth.signInEmailAndPassword(params),
    );
  }

  @override
  Future<Either<Failure, UserCredential>> signUpEmailAndPassword(
      AuthParameters params) {
    return executeOperation(
      () => _auth.signUpWithEmailAndPassword(params),
    );
  }

  @override
  Future<Either<Failure, User?>> checkIfUserLoggedIn() async {
    return executeOperation(() => _auth.checkIfUserLoggedIn());
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    return executeOperation(() => _auth.signOut());
  }
}
