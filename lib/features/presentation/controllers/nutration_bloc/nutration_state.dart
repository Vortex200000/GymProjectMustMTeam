part of 'nutration_bloc.dart';

sealed class NutrationState extends Equatable {
  const NutrationState();
  
  @override
  List<Object> get props => [];
}

final class NutrationInitial extends NutrationState {}


class GetUserMealsLoading extends NutrationState{}
class GetUserMealsLoaded extends NutrationState{
  final List<MealBlanEntity> meals;
  const GetUserMealsLoaded({required this.meals});
}
class GetUserMealsFailure extends NutrationState{
  final String error;
  const GetUserMealsFailure({required this.error});
}
