import 'package:dartz/dartz.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/core/usecase/base_use_case.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/domain/main_reposetories/user_main_repo.dart';

class GetAllUsersUseCase extends BaseUseCase<List<UserEntity>, NoParameters> {
  GetAllUsersUseCase(this._repo);
  final UserBaseRepo _repo;
  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParameters param) {
    return _repo.getAllUsers();
  }
}
