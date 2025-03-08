import 'package:dartz/dartz.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/core/usecase/base_use_case.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/domain/main_reposetories/user_main_repo.dart';

class GetCurrentUserUseCase extends BaseUseCase<UserEntity, NoParameters> {
  final UserBaseRepo _repo;
  GetCurrentUserUseCase(this._repo);
  @override
  Future<Either<Failure, UserEntity>> call(NoParameters param) async {
    return await _repo.getCurrentUserInfo();
  }
}
