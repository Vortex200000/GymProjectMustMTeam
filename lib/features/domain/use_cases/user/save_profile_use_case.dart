import 'package:dartz/dartz.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/core/usecase/base_use_case.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/domain/main_reposetories/user_main_repo.dart';

class SaveUserProfileUseCase extends BaseUseCase<UserEntity, UserEntity> {
  final UserBaseRepo _repo;

  SaveUserProfileUseCase(this._repo);

  @override
  Future<Either<Failure, UserEntity>> call(UserEntity param) {
    return _repo.saveUserProfile(param);
  }
}
