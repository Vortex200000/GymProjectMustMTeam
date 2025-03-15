import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mgym/core/usecase/base_use_case.dart';
import 'package:mgym/features/domain/entities/meal_blan_entity.dart';
import 'package:mgym/features/domain/use_cases/nutiration/get_user_meal_use_case.dart';

part 'nutration_event.dart';
part 'nutration_state.dart';

class NutrationBloc extends Bloc<NutrationEvent, NutrationState> {
  final GetUserMealsGoalUseCase _getUserMealsGoalUseCase;

  NutrationBloc(this._getUserMealsGoalUseCase) : super(NutrationInitial()) {
    on<GetUserMealsEvent>(_getUserMeals);
  }

  late List<MealBlanEntity> mealsUserGoal;
  Future<void> _getUserMeals(
      GetUserMealsEvent event, Emitter<NutrationState> emit) async {
    emit(GetUserMealsLoading());
    final result = await _getUserMealsGoalUseCase.call(NoParameters());
    result.fold((fail) {
      emit(GetUserMealsFailure(error: fail.message));
    }, (sucsess) {
      mealsUserGoal = sucsess;
      emit(GetUserMealsLoaded(meals: sucsess));
    });
  }
}
