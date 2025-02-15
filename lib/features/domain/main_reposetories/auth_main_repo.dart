import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/features/domain/use_cases/auth/log_email_password.dart';

abstract class AuthMainRepo {
  Future<Either<Failure, UserCredential>> loginEmailAndPassword(
      AuthParameters params);

  Future<Either<Failure, UserCredential>> signUpEmailAndPassword(
      AuthParameters params);


}
