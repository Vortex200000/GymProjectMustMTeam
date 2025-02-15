import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mgym/core/failures/remote_failure.dart';

abstract class BaseUseCase<T, Parameters> {
  Future<Either<Failure, T>> call(Parameters param);
}

abstract class StreamBaseUseCase<T, Parameters> {
  Stream<T> call(Parameters param);
}

class NoParameters extends Equatable {
  @override
  const NoParameters();
  @override
  List<Object?> get props => [];
}
