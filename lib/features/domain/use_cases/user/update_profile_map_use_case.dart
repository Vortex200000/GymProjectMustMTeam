import 'package:dartz/dartz.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/core/usecase/base_use_case.dart';
import 'package:mgym/features/domain/entities/user_entity.dart';
import 'package:mgym/features/domain/main_reposetories/user_main_repo.dart';

class UpdateProfileMapUseCase
    extends BaseUseCase<UserEntity, Map<String, dynamic>> {
  final UserBaseRepo _repo;
  UpdateProfileMapUseCase(this._repo);
  @override
  Future<Either<Failure, UserEntity>> call(Map<String, dynamic> param) async {
    return await _repo.updateUserProfileMap(param);
  }
}
