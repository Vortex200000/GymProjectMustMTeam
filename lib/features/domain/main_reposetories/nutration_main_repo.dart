import 'package:dartz/dartz.dart';
import 'package:mgym/core/failures/remote_failure.dart';
import 'package:mgym/features/domain/entities/meal_blan_entity.dart';

abstract class NutrationMainRepo {
  Future<Either<Failure, List<MealBlanEntity>>> getUserMealPlan();
}
