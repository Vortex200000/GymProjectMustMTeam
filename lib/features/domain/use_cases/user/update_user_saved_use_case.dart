import 'package:dartz/dartz.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/core/usecase/base_use_case.dart';
import 'package:mgym/features/domain/main_reposetories/user_main_repo.dart';


class UpdateUserProfSavedUseCase extends BaseUseCase<void, NoParameters> {
  final UserBaseRepo _repo;
  UpdateUserProfSavedUseCase(this._repo);
  @override
  Future<Either<Failure, void>> call(NoParameters param) async {
    return await _repo.updateUserProfSave();
  }
}
