import 'package:dartz/dartz.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/core/usecase/base_use_case.dart';
import 'package:mgym/features/domain/entities/meal_blan_entity.dart';
import 'package:mgym/features/domain/main_reposetories/nutration_main_repo.dart';

class GetUserMealsGoalUseCase
    extends BaseUseCase<List<MealBlanEntity>, NoParameters> {
  final NutrationMainRepo _repo;
  GetUserMealsGoalUseCase(this._repo);

  @override
  Future<Either<Failure, List<MealBlanEntity>>> call(NoParameters param) {
    return _repo.getUserMealPlan();
  }
}
