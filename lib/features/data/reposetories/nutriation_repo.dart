import 'package:dartz/dartz.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/features/data/data_source/remote_data/user_remote_data/user_remote_data.dart';
import 'package:mgym/features/data/reposetories/user_rebo.dart';
import 'package:mgym/features/domain/entities/meal_blan_entity.dart';
import 'package:mgym/features/domain/main_reposetories/nutration_main_repo.dart';

class NutriationRepo extends NutrationMainRepo {
  final UserRemoteData _remote;
  NutriationRepo(this._remote);
  @override
  Future<Either<Failure, List<MealBlanEntity>>> getUserMealPlan() {
    return executeOperation(() => _remote.getUserMealPlansAccToGoal());
  }
}
