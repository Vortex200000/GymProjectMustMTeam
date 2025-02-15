import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mgym/core/failures/remote_failure.dart';

Future<Either<Failure, T>> executeOperation<T>(
    Future<T> Function() operation) async {
  try {
    final result = await operation(); // Execute the provided operation
    return Right(result); // Wrap the result in a Right instance
  } on FirebaseException catch (fail) {
    return Left(ServerFailure(message: fail.message!));
  } catch (error) {
    // Handle specific errors, map to Failure
    return Left(ServerFailure(message: error.toString()));
  }
}
